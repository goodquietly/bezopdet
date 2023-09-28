class NoticeTimeJob
  include Sidekiq::Job
  sidekiq_options retry: 10, dead: false

  def perform
    ChildProgram.where.not(notice_time: nil).each do |program| 
      if program.notice_time.to_date == Date.current && program.user_subscribed?
        UserMailer.notice_time(program).deliver_later
        TelegramMailer.notice_time(program).deliver_later  if program.telegram_present?
      end

      program.update_columns(notice_time: nil) if program.notice_time.to_date < Date.current
    end
  end
end
