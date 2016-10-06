class Comment < ApplicationRecord
  validates :text, :commentable_type, :commentable_id, :user_id, presence: true
  validates :text, length: {minimum: 1}, allow_blank: false

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
