class UsersController < ApplicationController
  def show
    @user = current_user
    @programs = TrainingProgram.published
    @user_programs = UserProgram.where(user: @user)
  end
end
