class TrainingProgram < ApplicationRecord
  after_save_commit :update_program_for_users, on: %i[create update]

  validates :title, presence: true, uniqueness: true, length: { in: 3..500 }
  validates :url, presence: true
  validates :published, inclusion: [true, false]

  has_many :user_programs, dependent: :destroy
  has_many :users, through: :user_programs

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  private

  def update_program_for_users
    users = User.all

    return create_program_for_users(users) if published?

    delete_program_for_users(users)
  end

  def delete_program_for_users(users)
    users.map do |user|
      UserProgram.destroy_by(user_id: user.id, training_program_id: id)
    end
  end

  def create_program_for_users(users)
    users.map do |user|
      UserProgram.find_or_create_by(user_id: user.id, training_program_id: id)

      MailNotificationJob.set(wait: 1.minute).perform_later(user)
    end
  end
end
