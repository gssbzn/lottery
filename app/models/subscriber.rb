class Subscriber < ActiveRecord::Base
  validates :email, presence: true, length: { in: 2..50 }, email: true,
                    uniqueness:{case_sensitive:false}

  has_many :registrations, dependent: :destroy
  
  def to_s
    "email: #{self.email}"
  end
end
