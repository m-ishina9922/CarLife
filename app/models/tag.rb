class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy #postを削除するとpost_tag(中間テーブル)も削除される
  has_many :posts, through: :post_tags, dependent: :destroy

  #空白登録はNG
  validates :name, presence: true

  #重複の登録はNG
  validates :name, uniqueness: true


end
