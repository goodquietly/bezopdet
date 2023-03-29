class UserProgramsController < ApplicationController
  before_action :set_user_program

  def edit; end

  def update
    if @user_program.update(user_program_params)

      # TaskMailer.new_task(task).deliver_later

      redirect_to user_program_path(@user_program), notice: 'Вы установии напоминание'
    else
      render :edit
    end
  end

  def show; end

  def complete
    @user_program.update_columns(completed: true, notice_time: nil)

    redirect_to user_program_path(@user_program), notice: 'Методика пройдена! Поздравляем!'
  end

  private

  def set_user_program
    @user_program ||= authorize UserProgram.find(params[:id])
  end

  def user_program_params
    params.require(:user_program).permit(:notice_time)
  end
end
