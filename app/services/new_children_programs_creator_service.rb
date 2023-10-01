class NewChildrenProgramsCreatorService < ApplicationService
  def initialize(child)
    @child = child
  end
  
  def call
    create_new_children_program
  end

  private

  def create_new_children_program
    return unless TrainingProgram.published.present?
    
    TrainingProgram.published.map do |program|
      ChildProgram.find_or_create_by(child_id: @child.id, training_program_id: program.id)
    end
  end
end
