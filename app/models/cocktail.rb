class Cocktail < ApplicationRecord
  has_many  :doses
  has_many  :ingredients, through: :doses, dependent: :destroy
  has_many  :reviews, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
