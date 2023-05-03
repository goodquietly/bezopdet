class AddSubscribedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscribed, :boolean, null: false, default: false
  end
end
