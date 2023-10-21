# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :confirmable, :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :children, dependent: :destroy

  validates :subscribed, inclusion: [true, false]
  validates :personal_data_policy_confirmed, inclusion: [true, false]

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)

    return user if user.present?

    find_or_create_by(provider: auth.provider, uid: auth.uid) do |new_user|
      new_user.update(email:                          auth.info.email,
                      password:                       Devise.friendly_token[0, 20],
                      personal_data_policy_confirmed: true,
                      subscribed:                     true)
      new_user.skip_confirmation!
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
