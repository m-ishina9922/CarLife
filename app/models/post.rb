class Post < ApplicationRecord
  #画像データを保存できるようにする
  has_many_attached :images

  belongs_to :user
  has_many :processimages,  dependent: :destroy

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true

end
