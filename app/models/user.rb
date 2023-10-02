# frozen_string_literal: true

class User < ApplicationRecord
  after_update :update_children

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :confirmable

  has_many :children, dependent: :destroy

  validates :subscribed, inclusion: [true, false]
  validates :personal_data_policy_confirmed, inclusion: [true, false]

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def update_children
    return if personal_data_policy_confirmed?

    children.update_all(patronymic: '', residential_address: '', medical_policy_number: '',
                        allergies_and_drug_intolerance: '', verbal_portrait_and_special_features: '')
    Contact.where(child_id: children.ids).delete_all
  end
end
