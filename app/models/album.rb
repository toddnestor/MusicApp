class Album < ApplicationRecord
  validates :name, :band_id, presence: true

  belongs_to :band
  has_many :tracks, dependent: :destroy

  has_many :comments, as: :commentable
end
