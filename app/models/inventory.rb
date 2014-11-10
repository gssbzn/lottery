class Inventory < ActiveRecord::Base
  # Associations
  belongs_to :inventariable, polymorphic: true
  
  # Validations
  validates :qty_available, presence: true, numericality: true
  validates :inventariable, presence: true
  validates :inventariable_id, uniqueness: { scope: :inventariable_type }
  
  # Redouce the inventori of a given resource
  def self.reduce_inventory(inventariable)
    inv = Inventory.where(inventariable: inventariable).first
    unless inv.nil?      
      inv.qty_available -= 1
      inv.save
      return true
    end
    false
  end
end
