class ProgramRepetitionJob < ApplicationJob
  queue_as :default

  def perform(program)
    program.update_columns(completed: false, notice_time: nil)

    UserMailer.repeat_training_program(program).deliver_later
  end
end
