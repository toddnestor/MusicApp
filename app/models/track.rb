class Track < ApplicationRecord
  validates :album_id, :user_id, :track_type, :name, presence: true


  belongs_to :user
  belongs_to :album
  has_one :band,
    through: :album,
    source: :band

  has_many :comments, as: :commentable
end
