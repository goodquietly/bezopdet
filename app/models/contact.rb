class Contact < ApplicationRecord
  belongs_to :child

  validates :full_name, presence: true, length: { maximum: 100 }
  validates :role, inclusion: %w[Мама Папа Бабушка Дедушка Педиатр Другое]

  russian_phone :phone_number
  russian_phone :validated_phone, default_country: 7, allowed_cities: [495], validate: true
end
