class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :prizes, :name, unique: true
  end
end
