class Processimage < ApplicationRecord
  has_one_attached :image

  has_many :post
  has_many :user

  validates :text, presence: true
end
