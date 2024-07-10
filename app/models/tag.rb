class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy #postを削除するとpost_tag(中間テーブル)も削除される
  has_many :posts, through: :post_tags, dependent: :destroy

end
