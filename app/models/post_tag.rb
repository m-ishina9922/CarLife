class PostTag < ApplicationRecord
  belongs_to :post
  has_many :tags
end
