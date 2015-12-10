class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :provider, null: false
      table.string :uid, null: false, unique: true
      table.string :username, null: false, unique: true
      table.string :email, null: false, unique: true
      table.string :avatar_url, null: false

      table.timestamps null: false
    end

    add_index :users, [:uid, :provider], unique: true
  end
end
