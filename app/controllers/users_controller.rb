class UsersController < ApplicationController
  before_action :set_user

  def show
    @user_programs = policy_scope(UserProgram)
    start_date = params.fetch(:start_date, Date.today).to_date
    @notices = @user_programs
               .where(notice_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  def passport; end

  private

  def set_user
    @user = authorize User.find(params[:id])
  end
end
