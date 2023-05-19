class Child < ApplicationRecord
  before_save :capitalize_name

  belongs_to :user

  has_many :child_programs, dependent: :destroy
  has_many :training_programs, through: :child_programs
  has_many :contacts, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 35 }
  validates :last_name, presence: true, length: { maximum: 35 }
  validates :patronymic, presence: true, allow_blank: true, length: { maximum: 35 }
  validates :birthday, presence: true, comparison: { less_than: Date.current - 1.day }
  validates :residential_address, presence: true, allow_blank: true, length: { maximum: 100 }
  validates :allergies_and_drug_intolerance, presence: true, allow_blank: true, length: { maximum: 200 }
  validates :medical_policy_number, presence: true, allow_blank: true,
                                    format: { with: /\A\d{16}\z/, message: 'Введите 16 цифр - номер полиса' }
  validates :verbal_portrait_and_special_features, presence: true, allow_blank: true, length: { maximum: 255 }

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
