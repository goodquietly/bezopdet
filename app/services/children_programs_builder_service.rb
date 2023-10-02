# frozen_string_literal: true

class ChildrenProgramsBuilderService < ApplicationService
  def initialize(training_program)
    @training_program = training_program
  end

  def call
    build_children_programs
  end

  private

  def build_children_programs
    Child.find_each do |child|
      unless @training_program.published?
        next ChildProgram.destroy_by(child_id: child.id,
                                     training_program_id: @training_program.id)
      end

      program = ChildProgram.find_or_create_by(child_id: child.id, training_program_id: @training_program.id)

      next unless child.user.subscribed?

      UserMailer.new_training_program(program).deliver_later
      TelegramMailer.new_training_program(program).deliver_later if child.telegram_present?
    end
  end
end
