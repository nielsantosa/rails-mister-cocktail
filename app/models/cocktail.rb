class Cocktail < ApplicationRecord
  has_many  :doses
  has_many  :ingredients, through: :doses, dependent: :destroy
  has_many  :reviews, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
end
