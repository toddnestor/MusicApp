class Album < ApplicationRecord
  validates :name, :user_id, :band_id, presence: true

  belongs_to :band
  belongs_to :user
  has_many :tracks, dependent: :destroy

  has_many :comments, as: :commentable

  def self.search(keywords)
    Album.where("name ILIKE ?", "%#{keywords}%")
  end
end
