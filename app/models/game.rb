class Game < ActiveRecord::Base
  # For backend
  if defined? Rear
    include Rear
  end

  belongs_to :category

  validates :name, :content, presence: true
end
