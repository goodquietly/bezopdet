class UserProgramBuilderService < ApplicationService
  def initialize(model)
    @model = model
  end

  def call
    return create_programs_for_user if @model.instance_of? User

    build_program_for_users
  end

  private

  def create_programs_for_user
    TrainingProgram.published.map do |program|
      UserProgram.find_or_create_by(user_id: @model.id, training_program_id: program.id)
    end
  end

  def build_program_for_users
    User.all.find_each do |user|
      next UserProgram.destroy_by(user_id: user.id, training_program_id: @model.id) unless @model.published?

      program = UserProgram.find_or_create_by(user_id: user.id, training_program_id: @model.id)

      UserMailer.new_training_program(program).deliver_later
    end
  end
end
