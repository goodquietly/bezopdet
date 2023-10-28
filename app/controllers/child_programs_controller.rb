# frozen_string_literal: true

require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets'

class ChildProgramsController < ApplicationController
  before_action :set_child_program

  def edit; end

  def update
    child_program_params = params.require(:child_program).permit(:notice_time)

    if @child_program.update(child_program_params)
      redirect_to child_program_path(@child_program),
                  notice: 'Напоминание установлено! Вы получите email-уведомление в день события.'
    else
      render :edit
    end
  end

  def show; end

  def add_to_google_calendar
    client = get_google_calendar_client(current_user)
    if client.nil?
      redirect_back_or_to child_program_path(@child_program),
                          alert: 'Для добавления события в Ваш Google Calendar авторизуйтесь с помощью Вашей учетной
                                  записи Google!'
    else
      event = get_event(@child_program)
      client.insert_event('primary', event)
      redirect_back_or_to child_program_path(@child_program), notice: 'Событие добавлено в Ваш Google Calendar!'
    end
  rescue Google::Apis::AuthorizationError
    redirect_back_or_to child_program_path(@child_program),
                        alert: 'Возникла ошибка при добавлении усобытия в Ваш Google Calendar. Авторизуйтесь еще
                               раз с помощью Вашей учетной записи Google и повторите попытку.'
  end

  def complete
    @child_program.update_columns(completed: true, notice_time: nil, completed_at: Time.now)

    redirect_to child_program_path(@child_program),
                notice: 'Методика пройдена! Поздравляем! Рекомендуем повторно пройти методику через 3 месяца.'
  end

  private

  def set_child_program
    @child_program ||= authorize ChildProgram.find(params[:id])
  end

  def get_google_calendar_client(user)
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless user.present? && user.access_token.present? && user.refresh_token.present?

    secrets = Google::APIClient::ClientSecrets.new({
                                                     'web': {
                                                       'access_token':  user.access_token,
                                                       'refresh_token': user.refresh_token,
                                                       'client_id':     ENV.fetch('GOOGLE_CLIENT_ID', nil),
                                                       'client_secret': ENV.fetch('GOOGLE_CLIENT_SECRET', nil)
                                                     }
                                                   })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = 'refresh_token'

      unless user.present?
        client.authorization.refresh!
        user.update_attributes(
          access_token:  client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at:    client.authorization.expires_at.to_i
        )
      end
    rescue StandardError
      flash[:error] = 'Срок действия вашего токена истек. Пожалуйста, войдите еще раз с помощью Google.'
      redirect_to :back
    end
    client
  end

  def get_event(child_program)
    Google::Apis::CalendarV3::Event.new(
      summary:               "Изучение активности с #{child_program.child.last_name}",
      description:           "Запланировано изучение активности: '#{child_program.training_program.title}'",
      start:                 {
        date_time: child_program.notice_time.to_fs(:iso8601),
        time_zone: 'Europe/Moscow'
      },
      end:                   {
        date_time: (child_program.notice_time + 30.minutes).to_fs(:iso8601),
        time_zone: 'Europe/Moscow'
      },
      attendees:             [email: child_program.child.user.email],
      reminders:             {
        use_default: false,
        overrides:   [
          Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'popup', minutes: 10),
          Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'email', minutes: 20)
        ]
      },
      notification_settings: {
        notifications: [
          { type: 'event_creation', method: 'email' },
          { type: 'event_change', method: 'email' },
          { type: 'event_cancellation', method: 'email' },
          { type: 'event_response', method: 'email' }
        ]
      },
      'primary':             true
    )
  end
end
