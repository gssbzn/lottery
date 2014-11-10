class AvailablePrize < ActiveRecord::Base
  # Associations
  belongs_to :prize
  
  # Validations
  validates :prize, presence: true
  
  # Callbacks
  before_destroy :reduce_inventory
  
  protected
  
  # If a prize is given reduce inventory
  def reduce_inventory
    Inventory.reduce_inventory(prize)
  end
  
end
