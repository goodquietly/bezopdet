# frozen_string_literal: true

if Rails.env.development?
  AdminUser.create!(email: ENV['EMAIL_DEV'], password: ENV['EMAIL_DEV_PASS'],
                    password_confirmation: ENV['EMAIL_DEV_PASS'])
end

if Rails.env.production?
  AdminUser.create!(email: ENV['EMAIL_PROD'], password: ENV['EMAIL_PROD_PASS'],
                    password_confirmation: ENV['EMAIL_PROD_PASS'])
end
