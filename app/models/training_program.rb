class TrainingProgram < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { in: 3..500 }
  validates :url, presence: true
  validates :published, inclusion: [true, false]
end
