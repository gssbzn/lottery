class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.belongs_to :subscriber, index: true
      t.integer :number, null: false
      t.date :created_at, null: false
    end
  end
end
