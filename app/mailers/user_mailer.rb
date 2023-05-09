class UserMailer < ApplicationMailer
  def new_training_program(program)
    @program = program

    bootstrap_mail(
      to: @program.child.user.email,
      subject: 'Безопасное детство - опубликована новая активность!'
    )
  end

  def notice_time(program)
    @program = program

    bootstrap_mail(
      to: @program.child.user.email,
      subject: 'Безопасное детство - напоминание!'
    )
  end

  def repeat_training_program(program)
    @program = program

    bootstrap_mail(
      to: @program.child.user.email,
      subject: 'Безопасное детство - пришло время повторить активность!'
    )
  end
end
