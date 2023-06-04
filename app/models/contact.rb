class Contact < ApplicationRecord
  belongs_to :child

  enum role: { mother: 'mother', father: 'father', grandmother: 'grandmother', grandfather: 'grandfather',
               pediatrician: 'pediatrician', other: 'other' }

  validates :full_name, presence: true, length: { maximum: 100 }
  validates :role, inclusion: %w[mother father grandmother grandfather pediatrician other]
  validates :phone_number, presence: true

  russian_phone :phone_number
  russian_phone :validated_phone, default_country: 7, allowed_cities: [495], validate: true

  translate_enum :role
end
