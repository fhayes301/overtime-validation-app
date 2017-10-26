class Post < ApplicationRecord
  belongs_to :user, optional: true
  validates :date, :rationale, presence: true

end
