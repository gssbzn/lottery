class CreateAvailablePrizes < ActiveRecord::Migration
  def change
    create_table :available_prizes do |t|
      t.references :prize, index: true

      t.timestamps
    end
  end
end
