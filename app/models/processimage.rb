class Processimage < ApplicationRecord
  has_one_attached :image

  belongs_to :post
  belongs_to :user

  validates :text, presence: true
end
