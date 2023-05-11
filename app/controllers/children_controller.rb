class ChildrenController < ApplicationController
  before_action :set_child, only: %i[edit update show destroy passport]

  def new
    @child = authorize Child.new(user: current_user)
  end

  def create
    @child = authorize Child.new(child_params)

    if @child.save
      ChildProgramBuilderService.call(@child)

      redirect_to child_path(@child), notice: "#{@child.full_name} - личный кабинет успешно сформирован!"
    else
      render :new
    end
  end

  def show
    @child_programs ||= policy_scope(ChildProgram)
    start_date = params.fetch(:start_date, Date.today).to_date
    @notices = @child_programs
               .where(notice_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  def edit; end

  def update
    if @child.update(child_params)
      redirect_to child_path(@child), notice: "#{@child.full_name} - данные успешно обновлены!"
    else
      render :edit
    end
  end

  def destroy
    name = @child.full_name

    @child.destroy

    redirect_to root_path, notice: "#{name} - личный кабинет успешно удален!"
  end

  def passport
    respond_to do |format|
      format.html
      format.pdf do
        relative_html = ChildrenController.new.render_to_string(
          {
            template: 'children/passport',
            layout: 'pdf',
            assigns: { child: @child }
          }
        )

        absolute_html = Grover::HTMLPreprocessor.process relative_html, 'http://213.139.211.121/', 'http'
        pdf = Grover.new(absolute_html).to_pdf

        send_data(pdf, filename: "Passport_#{@child.full_name}_#{Date.current}", type: 'application/pdf')
      end
    end
  end

  private

  def set_child
    @child ||= authorize Child.find(params[:id])
  end

  def child_params
    params.require(:child).permit(:first_name, :last_name, :birthday, :user_id)
  end
end
