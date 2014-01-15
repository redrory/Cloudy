class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :address1
      t.string :city
      t.string :country
      t.string :telephoneNo
      t.string :role
      t.string :email

      t.timestamps
    end
  end
end
