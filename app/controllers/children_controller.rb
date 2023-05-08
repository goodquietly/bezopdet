class ChildrenController < ApplicationController
  before_action :set_child_and_programs

  def show
    start_date = params.fetch(:start_date, Date.today).to_date
    @notices = @child_programs
               .where(notice_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  def passport
    respond_to do |format|
      format.html
      format.pdf do
        relative_html = ChildrenController.new.render_to_string(
          {
            template: 'children/passport',
            layout: 'pdf',
            assigns: { child: @child,
                       child_programs: @child_programs }
          }
        )

        absolute_html = Grover::HTMLPreprocessor.process relative_html, 'http://213.139.211.121/', 'http'
        pdf = Grover.new(absolute_html).to_pdf

        send_data(pdf, filename: "Passport_#{@child.full_name}_#{Date.current}", type: 'application/pdf')
      end
    end
  end

  private

  def set_child_and_programs
    @child ||= authorize Child.find(params[:id])
    @child_programs ||= policy_scope(ChildProgram)
  end
end
