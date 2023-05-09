class ChildProgramBuilderService < ApplicationService
  def initialize(model)
    @model = model
  end

  def call
    return create_programs_for_child if @model.instance_of? Child

    build_program_for_childs
  end

  private

  def create_programs_for_child
    return unless TrainingProgram.published.present?

    TrainingProgram.published.map do |program|
      ChildProgram.find_or_create_by(child_id: @model.id, training_program_id: program.id)
    end
  end

  def build_program_for_childs
    Child.find_each do |child|
      next ChildProgram.destroy_by(child_id: child.id, training_program_id: @model.id) unless @model.published?

      program = ChildProgram.find_or_create_by(child_id: child.id, training_program_id: @model.id)

      UserMailer.new_training_program(program).deliver_later if child.user.subscribed?
    end
  end
end
