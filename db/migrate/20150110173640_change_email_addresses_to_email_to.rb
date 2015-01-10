class ChangeEmailAddressesToEmailTo < ActiveRecord::Migration
  def up
    EmailAddress.destroy_all
    remove_column :email_addresses, :person_id
    add_column :email_addresses, :email_to_id, :integer
    add_column :email_addresses, :email_to_type, :string
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
