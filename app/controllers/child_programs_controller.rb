class ChildProgramsController < ApplicationController
  before_action :set_child_program

  def edit; end

  def update
    child_program_params = params.require(:child_program).permit(:notice_time)

    if @child_program.update(child_program_params)
      redirect_to child_program_path(@child_program),
                  notice: 'Напоминание установлено! Вы получите email-уведомление в день события.'
    else
      render :edit
    end
  end

  def show; end

  def complete
    @child_program.update_columns(completed: true, notice_time: nil, completed_at: Time.now)

    redirect_to child_program_path(@child_program),
                notice: 'Методика пройдена! Поздравляем! Рекомендуем повторно пройти методику через 3 месяца.'
  end

  private

  def set_child_program
    @child_program ||= authorize ChildProgram.find(params[:id])
  end
end
