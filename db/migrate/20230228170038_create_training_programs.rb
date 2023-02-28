class CreateTrainingPrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :training_programs do |t|
      t.string :title, null: false, index: { unique: true }
      t.text :url, null: false
      t.boolean :published, null: false, default: false

      t.timestamps
    end
  end
end
