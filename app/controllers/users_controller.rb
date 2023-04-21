class UsersController < ApplicationController
  before_action :set_user

  def show
    @user_programs = policy_scope(UserProgram)
    start_date = params.fetch(:start_date, Date.today).to_date
    @notices = @user_programs
               .where(notice_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  def passport
    respond_to do |format|
      format.html

      format.pdf do
        html_string = ActionController::Base.new.render_to_string(
          {
            template: 'users/passport',
            layout: 'pdf',
            assigns: { user: @user }
          }
        )

        pdf = Grover.new(html_string).to_pdf

        send_data(pdf, filename: "Passport_#{@user.full_name}_#{Date.current}", type: 'application/pdf')
      end
    end
  end

  private

  def set_user
    @user = authorize User.find(params[:id])
  end
end
