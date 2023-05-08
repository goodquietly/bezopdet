class Child < ApplicationRecord
  before_save :capitalize_name

  belongs_to :user

  has_many :child_programs, dependent: :destroy
  has_many :training_programs, through: :child_programs

  validates :first_name, presence: true, length: { maximum: 35 }
  validates :last_name, presence: true, length: { maximum: 35 }
  validates :birthday, presence: true, comparison: { less_than: Date.current - 1.day }

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    (Time.now.to_fs(:number).to_i - birthday.to_time.to_fs(:number).to_i) / 10e9.to_i
  end

  def age_to_s
    I18n.t('activerecord.models.age', count: age)
  end

  private

  def capitalize_name
    first_name&.capitalize!
    last_name&.capitalize!
  end
end
