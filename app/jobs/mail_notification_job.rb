class MailNotificationJob
  include Sidekiq::Job

  def perform(*_args)
    UserProgram.find_each do |program|
      if program.completed? && program.completed_at.to_date < Date.current - 3.months
        program.update_columns(completed: false, notice_time: nil)

        UserMailer.repeat_training_program(program).deliver_later
      end

      if program.notice_time.present? && program.notice_time.to_date == Date.current
        UserMailer.notice_time(program).deliver_later
      end
    end
  end
end
