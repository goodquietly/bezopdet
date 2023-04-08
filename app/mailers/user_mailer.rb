class UserMailer < ApplicationMailer
  def new_training_program(program)
    @greeting = 'Hi'

    bootstrap_mail(
      to: program.user.email,
      # from: 'from@example.com',
      subject: 'Опубликована новая активность!'
    )
  end

  def notice_time(user)
    @greeting = 'Hi'

    bootstrap_mail(
      to: user.user.email,
      # from: 'from@example.com',
      subject: 'Напоминание от Безопасного детства!'
    )
  end

  def repeat_training_program(user)
    @greeting = 'Hi'

    bootstrap_mail(
      to: user.user.email,
      # from: 'from@example.com',
      subject: 'Пришло время повторить активность!'
    )
  end
end
