class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :firstName
      t.string :lastName
      t.string :dob
      t.string :phoneNumber
      t.string :address
      t.boolean :isAdmin, default: false

      t.timestamps
    end
  end
end
