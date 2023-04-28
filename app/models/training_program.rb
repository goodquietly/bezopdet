class TrainingProgram < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { in: 3..500 }
  validates :url, presence: true
  validates :published, inclusion: [true, false]
  validates :pdf, attached: true, content_type: %i[pdf jpg jpeg],
                  size: { between: 1.kilobyte..5.megabytes }

  has_many :user_programs, dependent: :destroy
  has_many :users, through: :user_programs

  has_one_attached :pdf

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
end
