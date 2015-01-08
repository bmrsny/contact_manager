class ChangePhoneNumbersToContacts < ActiveRecord::Migration
  def up
    PhoneNumber.destroy_all
    remove_column :phone_numbers, :person_id, :integer
    add_column :phone_numbers, :contact_id, :integer
    add_column :phone_numbers, :contact_type, :string
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
