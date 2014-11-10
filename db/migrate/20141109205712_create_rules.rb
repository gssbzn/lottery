class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :name, null: false
      t.references :prize, null: false
      t.string :participant_number
      t.string :participant_number_multiple
      t.integer :participant_number_after, default: 0

      t.timestamps
    end
    
    add_index :rules, :prize_id
    
  end
end
