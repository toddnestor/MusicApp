class Band < ApplicationRecord
  validates :name, :user_id, presence: true

  belongs_to :user

  has_many :albums, dependent: :destroy
  has_many :songs,
    through: :albums,
    source: :tracks

  has_many :comments, as: :commentable

  def self.search(keywords)
    Band.where("name ILIKE ?", "%#{keywords}%")
  end
end
