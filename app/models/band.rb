class Band < ApplicationRecord
  validates :name, presence: true

  has_many :albums, dependent: :destroy
  has_many :songs,
    through: :albums,
    source: :tracks

  has_many :comments, as: :commentable
end
