# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :full_name, null: false, default: ''
      t.string :phone_number, null: false, default: ''
      t.references :child, null: false, foreign_key: true

      t.timestamps
    end
    add_index :contacts, %i[phone_number child_id], unique: true
  end
end
