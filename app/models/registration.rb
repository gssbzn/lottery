#Participant chance
class Registration < ActiveRecord::Base
  # Associations
  belongs_to :subscriber  
  belongs_to :prize
  
  # Validations
  validates :subscriber, presence: true, uniqueness: { scope: :created_at, message: "You can participate once a day" }

  # Callbacks
  before_validation :set_number
  before_create :set_prize

  # Virtual column to create subsciber
  attr_accessor :email

  # initialize date
  def after_initialize
    set_created_at
  end

  protected
  
  # Set participant number
  def set_number
    max_number = Registration.maximum(:number)
    self.number = max_number.to_i + 1
  end
  
  # Set created date as today
  def set_created_at
    self.created_at ||= Date.today if new_record?
  end
  
  # Define a prize 
  def set_prize
    # Get an available prize
    winning_prize = Prize.winning_prize self.number  
    unless winning_prize.nil? # if a prize is available
      self.prize_id = winning_prize.prize_id
      winning_prize.destroy #release prize
    end
  end
  
  # String representation
  def to_s
    "#{self.email}"
  end
  
end
