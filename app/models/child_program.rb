class ChildProgram < ApplicationRecord
  validates :completed, inclusion: [true, false]

  validates :notice_time, comparison: { greater_than: Date.current }, on: :update

  belongs_to :child
  belongs_to :training_program

  def start_time
    notice_time
  end
end
