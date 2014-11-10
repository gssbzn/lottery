class Rule < ActiveRecord::Base
  # Associations
  belongs_to :prize
  
  # Validations
  validates :name, :prize, presence: true
  validates :participant_number, presence: true, unless: :participant_number_multiple?
  validates :participant_number_multiple, presence: true, unless: :participant_number?
  
  # Verify for a given participant number if complies to a rule
  # if so a prize is set apart for hin or in case rules overlap for a next participant  
  def self.generate_prizes(participant_number)
    rules = Rule.includes(prize: [:inventory]).where('participant_number_after < ?', participant_number).order(:created_at)
    rules.each do |rule|
      if(rule.prize.inventory.qty_available.to_i > 0)
        if rule.participant_number?
          # Verify especific participants  
          verify_especific participant_number, rule.participant_number, rule.prize
        elsif rule.participant_number_multiple?
          # Verefy if participants if multiple of given rule
          verify_multiple participant_number, rule.participant_number_multiple, rule.prize
        end
      end
    end
  end
  
  # String representation
  def to_s
    "#{self.name}"
  end
  
  private 
  
  # Verify especific participants 
  # make a prize available if so
  def self.verify_especific(participant_number, numbers, prize)
    winners = numbers.split(', ')
    if winners.include? participant_number.to_s
      available_prize = AvailablePrize.new prize: prize
      available_prize.save!
    end
  end
  
  # Verefy if participant if multiple of given rule
  # make a prize available if so
  def self.verify_multiple(participant_number, multiples, prize)
    winners = multiples.split(', ')
    winners.each do |multiple|
      if participant_number.to_i % multiple.to_i == 0
        available_prize = AvailablePrize.new prize: prize
        available_prize.save!
      end
    end
  end
end
