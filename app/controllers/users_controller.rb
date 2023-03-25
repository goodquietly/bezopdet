class UsersController < ApplicationController
  def show
    @user = current_user
    @programs = TrainingProgram.published
    @user_programs = UserProgram.where(user: @user)
    start_date = params.fetch(:start_date, Date.today).to_date
    @notices = UserProgram.where(notice_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end
end
