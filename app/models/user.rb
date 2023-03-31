class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :trackable, :lockable

  before_save :capitalize_name
  after_save_commit :create_user_program, on: :create

  validates :first_name, presence: true, length: { maximum: 35 }
  validates :last_name, presence: true, length: { maximum: 35 }
  validates :birthday, presence: true

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

  private

  def create_user_program
    programs = TrainingProgram.published

    programs.map do |program|
      UserProgram.find_or_create_by(user_id: id, training_program_id: program.id)
    end
  end

  def capitalize_name
    first_name&.capitalize!
    last_name&.capitalize!
  end
end
