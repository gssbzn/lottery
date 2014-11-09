class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.belongs_to :subscriber, index: true
      t.integer :number
      t.date :created_at
    end
  end
end
