class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :confirmable

  has_many :children, dependent: :destroy

  validates :subscribed, inclusion: [true, false]
  validates :personal_data_policy_confirmed, inclusion: [true, false]

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
