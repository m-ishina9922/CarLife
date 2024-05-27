class Tag < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :post_tags




end
