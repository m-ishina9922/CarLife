class PostTag < ApplicationRecord
  belongs_to :post
  has_many :tag
end
