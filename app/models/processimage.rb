class Processimage < ApplicationRecord
  has_one_attached :image

  belongs_to :post

  #validates :text, presence: true
end
