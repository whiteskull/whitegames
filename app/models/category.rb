class Category < ActiveRecord::Base
  # For backend
  if defined? Rear
    include Rear
  end

  has_many :games, dependent: :destroy

  validates :name, presence: true
end
