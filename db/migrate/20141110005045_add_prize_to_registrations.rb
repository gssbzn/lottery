class AddPrizeToRegistrations < ActiveRecord::Migration
  def change
    add_reference :registrations, :prize, index: true
  end
end
