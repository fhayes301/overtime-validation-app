class Post < ApplicationRecord
  validates :date, :rationale, presence: true

  def index
  end 
end
