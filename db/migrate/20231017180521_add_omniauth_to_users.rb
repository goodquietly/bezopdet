class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :last_sign_in_by, :string
    add_column :users, :access_token, :string
    add_column :users, :expires_at, :datetime
    add_column :users, :refresh_token, :string
  end
end
