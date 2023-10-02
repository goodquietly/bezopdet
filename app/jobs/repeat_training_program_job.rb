# frozen_string_literal: true

class RepeatTrainingProgramJob
  include Sidekiq::Job
  sidekiq_options retry: 10, dead: false

  def perform
    ChildProgram.where(completed: true, completed_at: ..3.months.ago).each do |program|
      program.update_columns(completed: false, notice_time: nil)

      next unless program.user_subscribed?

      UserMailer.repeat_training_program(program).deliver_later
      TelegramMailer.repeat_training_program(program).deliver_later if program.telegram_present?
    end
  end
end
