class ChildProgramsController < ApplicationController
  before_action :set_child_program

  def edit; end

  def update
    if @child_program.update(child_program_params)
      UserMailer.notice_time(@child_program).deliver_later

      redirect_to child_program_path(@child_program),
                  notice: 'Напоминание установлено. Вы получите email-уведомление в день события.'
    else
      render :edit
    end
  end

  def show; end

  def complete
    @child_program.update_columns(completed: true, notice_time: nil, completed_at: Time.now)

    UserMailer.repeat_training_program(@child_program).deliver_later

    redirect_to child_program_path(@child_program),
                notice: 'Методика пройдена! Поздравляем! Рекомендуем повторно пройти методику через 3 месяца.'
  end

  private

  def set_child_program
    @child_program ||= authorize ChildProgram.find(params[:id])
  end

  def child_program_params
    params.require(:child_program).permit(:notice_time)
  end
end
