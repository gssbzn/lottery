## Inventory for different things
class Inventory < ActiveRecord::Base
  # Associations
  belongs_to :inventariable, polymorphic: true
  
  # Validations
  validates :qty_available, presence: true, numericality: true
  validates :inventariable, presence: true
  validates :inventariable_id, uniqueness: { scope: :inventariable_type }
  
  # Redouce the inventory of a given resource
  def self.reduce_inventory(inventariable)
    Inventory.where(inventariable: inventariable).first.decrement!(:qty_available)
  end
  
  # String representation
  def to_s
    "#{self.name}"
  end
  
end
