class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |table|
      table.integer :user_id, null: false
      table.integer :meetup_id, null: false
      table.index[:user_id, :meetup_id], unique: true
    end
  end
end
