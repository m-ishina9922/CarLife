class Post < ApplicationRecord
  attr_accessor :tag_string
  
  belongs_to :user
  has_many :processimages, dependent: :destroy
  accepts_nested_attributes_for :processimages, allow_destroy: true
  
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #tag関連のアソシエーション
  has_many :post_tags, dependent: :destroy #中間テーブル
  has_many :tags, through: :post_tags, dependent: :destroy

  validates :title, presence: true


  #検索方法の条件分岐
 #LIKEによるあいまい検索の構文を使用
 #部分一致のみ
   def self.looks(search, word)
      @post = Post.where("title LIKE?", "%#{word}%")
   end

   #渡されたユーザーidがfavoriteテーブル内に存在するかを調べるメソッド（存在すればtrue,存在しなければfalse)
   def favorited_by?(user)
     favorites.exists?(user_id: user.id)
   end

end
