class Processimage < ApplicationRecord
  has_one_attached :image

  belongs_to :post
  has_many :user

  validates :text, presence: true
end
