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
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true


  #検索方法の条件分岐
 #LIKEによるあいまい検索の構文を使用
   def self.looks(search, word)
     if search == "perfect_match" #検索方法が完全一致だった場合
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "forward_match" #検索方法が前方一致だった場合
      @post = Post.where("title LIKE?", "#{word}%")
    elsif search == "backward_match" #検索方法が後方一致だった場合
      @post = Post.where("title LIKE?", "%#{word}")
    elsif search == "partial_match" #検索方法が部分一致だった場合
      @post = Post.where("title LIKE?", "%#{word}%")
    else
      @post = Post.all
    end

   end
end
