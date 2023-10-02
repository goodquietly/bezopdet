# frozen_string_literal: true

class CreateChildPrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :child_programs do |t|
      t.boolean :completed, null: false, default: false
      t.datetime :completed_at
      t.datetime :notice_time
      t.references :child, null: false, foreign_key: true
      t.references :training_program, null: false, foreign_key: true

      t.timestamps
    end
  end
end
