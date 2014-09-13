class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :phone_no
      t.string :address
      t.string :customer_type
      t.integer :nip

      t.timestamps
    end
  end
end
