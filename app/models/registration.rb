class Registration < ActiveRecord::Base

  validates :subscriber, presence: true, uniqueness: { scope: :created_at }

  before_create :set_number
  #before_validation :set_created_at

  belongs_to :subscriber

  attr_accessor :email

  def after_initialize
    set_created_at
  end

  protected
  def set_number
    max_number = Registration.maximum(:number)
    self.number = max_number.to_i + 1
  end

  def set_created_at
    self.created_at ||= Date.today if new_record?
  end
end
