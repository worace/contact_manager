class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.integer :person_id
      t.string :address

      t.timestamps
    end
  end
end
