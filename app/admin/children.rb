# frozen_string_literal: true

ActiveAdmin.register Child do
  permit_params :first_name, :last_name, :birthday
end
