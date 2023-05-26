class AddRoleToContacts < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE contact_role AS ENUM ('mother', 'father', 'grandmother', 'grandfather', 'pediatrician', 'other');
    SQL
    add_column :contacts, :role, :contact_role
    add_index :contacts, :role
  end

  def down
    remove_column :contacts, :role
    execute <<-SQL
      DROP TYPE contact_role;
    SQL
  end
end
