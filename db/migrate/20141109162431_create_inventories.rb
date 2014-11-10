class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :qty_available
      t.references :inventariable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
