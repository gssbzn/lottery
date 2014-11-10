## Give away prizes
class Prize < ActiveRecord::Base
  # Associations
  has_one :inventory, as: :inventariable, dependent: :destroy
  has_many :rules, dependent: :destroy
  has_many :available_prizes, dependent: :destroy
 
  # Validations
  validates :name, presence: true, uniqueness:{case_sensitive:false}

  # Virtual column for inventory
  attr_accessor :qty_available
  
  # Get available prize for a participant
  def self.winning_prize(participant_number)
    Rule.generate_prizes(participant_number)
    available_prize = AvailablePrize.order(:created_at).first
    available_prize
  end
  
  # String representation
  def to_s
    "#{self.name}"
  end
end
