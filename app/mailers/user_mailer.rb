class UserMailer < ApplicationMailer
  def new_training_program(program)
    @program = program

    bootstrap_mail(
      to: @program.user.email,
      subject: 'Опубликована новая активность!'
    )
  end

  def notice_time(program)
    @program = program

    bootstrap_mail(
      to: @program.user.email,
      subject: 'Напоминание от Безопасного детства!'
    )
  end

  def repeat_training_program(program)
    @program = program

    bootstrap_mail(
      to: @program.user.email,
      subject: 'Пришло время повторить активность!'
    )
  end
end
