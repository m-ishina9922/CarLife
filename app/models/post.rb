class Post < ApplicationRecord
  #画像データを保存できるようにする
  has_one_attached :image1
  has_one_attached :image2
  has_one_attached :image3
  has_one_attached :image4
  has_one_attached :image5
  has_one_attached :image6
  has_one_attached :image7
  has_one_attached :image8
  has_one_attached :image9
  has_one_attached :image10


  belongs_to :user
  has_many :processimages,  dependent: :destroy

  #tag関連のアソシエーション
  has_many :post_tags, dependent: :destroy #中間テーブル
  has_many :tags, through: :post_tags

  validates :title, presence: true


  #検索方法の条件分岐
 #LIKEによるあいまい検索の構文を使用
 #部分一致のみ
   def self.looks(search, word)
      @post = Post.where("title LIKE?", "%#{word}%")
   end
end
