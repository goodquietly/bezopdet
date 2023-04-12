class MailNotificationJob
  include Sidekiq::Job

  def perform(*_args)
    UserProgram.find_each do |program|
      # program.update_columns(completed: false, notice_time: nil) # 2 - 3 months
      # UserMailer.repeat_training_program(program).deliver_later # 2 - 3 months

      # UserMailer.notice_time(program).deliver_later # 3
    end
  end
end
