# frozen_string_literal: true

class CreateChildren < ActiveRecord::Migration[7.0]
  def change
    create_table :children do |t|
      t.string :first_name, null: false
      t.string :patronymic, null: false, default: ''
      t.string :last_name, null: false
      t.date :birthday, null: false
      t.string :residential_address, null: false, default: ''
      t.string :allergies_and_drug_intolerance, null: false, default: ''
      t.string :medical_policy_number, null: false, default: ''
      t.string :verbal_portrait_and_special_features, null: false, default: ''

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
