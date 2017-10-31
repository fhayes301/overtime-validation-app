class Post < ApplicationRecord
  enum status: { submitted: 0, rejected: 2, approved: 1}
  belongs_to :user
  validates :date, :rationale, presence: true

  scope :posts_by, ->(user) { where(user_id: user.id) }
end
