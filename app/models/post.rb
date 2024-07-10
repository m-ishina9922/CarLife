class Post < ApplicationRecord
  attr_accessor :tags_string

  after_save :update_post_tags
  after_find :tags_to_s

  belongs_to :user
  has_many :processimages, dependent: :destroy

  #:processimagesを子レコードとして作成、:textと:imageが空の時はパラメーターを削除する
  accepts_nested_attributes_for :processimages, reject_if: proc { |attributes| attributes['text'].blank? && attributes['image'].blank? }, allow_destroy: true


  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #tag関連のアソシエーション
  has_many :post_tags, dependent: :destroy #中間テーブル
  has_many :tags, through: :post_tags, dependent: :destroy

  #バリデーション記述
  validates_associated :processimages
  validates :title, presence: true
  validates :processimages, presence: true


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

   private

   def update_post_tags
      # フォームからの文字をスペース区切りで配列に変換
     form_tag_names = self.tags_string.split(/[[:blank:]]+/).uniq.compact
      # すでに紐づけられているタグの名前だけを配列に抽出
      old_tag_names = self.tags.pluck(:name)
      # 入力されたタグから、古いタグを除いたもの
      new_tag_names = form_tag_names - old_tag_names

      # 古いタグの処理
      old_tag_names.each do |name|
        tag = Tag.find_by(name: name)
        # Tagに紐づいた中間テーブルをすべて確定
        post_tags = tag.post_tags
        # その中から現在のPostに紐づいたものを特定
        post_tag = post_tags.find_by(post_id self.id)
        # 該当TagとPostの結びつきを削除
        post_tag.destroy
        # もし該当Tagが使われていないTagならそれも削除
        if post_tags.size <= 1
          tag.destroy
        end
      end

      # 新しいタグの処理
      new_tag_names.each do |name|
        # 既存のタグならそれを呼び出し、新規なら作成
        tag = Tag.find_or_create_by(name: name)
        # TagとPostの中間テーブルを作成
        self.post_tags.find_or_create_by(tag_id: tag.id)
      end
    end

    def tags_to_s
      # 紐づいているタグの名前を配列で取得し、スペース区切りの文字で tags_string の疑似絡むに返す
      self.tags_string = self.tags.pluck(:name).join(" ")
      # 最終行でselfを戻り値として戻す。
      self
    end

end
