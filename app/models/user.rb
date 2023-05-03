class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :confirmable

  before_save :capitalize_name

  validates :first_name, presence: true, length: { maximum: 35 }
  validates :last_name, presence: true, length: { maximum: 35 }
  validates :birthday, presence: true, comparison: { less_than: Date.current - 1.day }

  has_many :user_programs, dependent: :destroy
  has_many :training_programs, through: :user_programs

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

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
