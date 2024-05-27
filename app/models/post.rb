class Post < ApplicationRecord
  belongs_to :user
  has_many :processimages,  dependent: :destroy

  has_many :post_tags
  has_many :tags

  validates :title, presence: true

end
