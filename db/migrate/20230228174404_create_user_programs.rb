class CreateUserPrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :user_programs do |t|
      t.boolean :completed, null: false, default: false
      t.datetime :notice_time
      t.references :user, null: false, foreign_key: true
      t.references :training_program, null: false, foreign_key: true

      t.timestamps
    end
  end
end
