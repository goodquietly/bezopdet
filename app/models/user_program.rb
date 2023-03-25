class UserProgram < ApplicationRecord
  validates :completed, inclusion: [true, false]

  validates :notice_time, comparison: { greater_than: Date.tomorrow }, on: :update

  belongs_to :user
  belongs_to :training_program
end
