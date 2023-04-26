class MailNotificationJob
  include Sidekiq::Job
  sidekiq_options retry: 10, dead: false

  def perform
    UserProgram.find_each do |program|
      if program.completed? && program.completed_at.to_date < Date.current - 3.months
        program.update_columns(completed: false, notice_time: nil)
        UserMailer.repeat_training_program(program).deliver_later
      end

      return unless program.notice_time.present?

      UserMailer.notice_time(program).deliver_later if program.notice_time.to_date == Date.current
      program.update_columns(notice_time: nil) if program.notice_time.to_date < Date.current
    end
  end
end
