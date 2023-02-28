class UserProgram < ApplicationRecord
  validates :completed, inclusion: [true, false]

  belongs_to :user
  belongs_to :training_program
end
