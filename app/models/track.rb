class Track < ApplicationRecord
  validates :album_id, :track_type, :name, presence: true

  belongs_to :album
  has_one :band,
    through: :album,
    source: :band

end
