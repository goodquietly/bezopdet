class UserProgramBuilderService < ApplicationService
  def initialize(program)
    @program = program
  end

  def call
    return create_program_for_users if @program.published?

    delete_program_for_users
  end

  private

  def delete_program_for_users
    User.all.map do |user|
      UserProgram.destroy_by(user_id: user.id, training_program_id: @program.id)
    end
  end

  def create_program_for_users
    User.all.map do |user|
      program = UserProgram.find_or_create_by(user_id: user.id, training_program_id: @program.id)

      UserMailer.new_training_program(program).deliver_later
    end
  end
end
