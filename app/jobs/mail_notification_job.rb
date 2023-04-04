class MailNotificationJob < ApplicationJob
  queue_as :default

  def perform(model)
    return UserMailer.new_training_program(model).deliver_later if model.instance_of?(User)

    UserMailer.notice_time(model).deliver_later
  end
end
