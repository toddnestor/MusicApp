class Comment < ApplicationRecord
  validates :text, :commentable_type, :commentable_id, :user_id, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
