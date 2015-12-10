class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.string :name, null: false, unique: true
      table.string :details, null: false, length: { maximum: 1000 }
      table.string :location, null: false
      table.integer :creator_id, null: false

      table.timestamps null: false
    end
  end
end
