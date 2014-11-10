## Registered participant
class Subscriber < ActiveRecord::Base
  # Associations
  has_many :registrations, dependent: :destroy
  
  # Validations
  validates :email, presence: true, length: { in: 2..50 }, email: true,
                    uniqueness:{case_sensitive:false}  
  
  # String representation
  def to_s
    "#{self.email}"
  end
end
