class AddCompletedAtToUserProgram < ActiveRecord::Migration[7.0]
  def change
    add_column :user_programs, :completed_at, :datetime
  end
end
