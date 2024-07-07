class PostsForm
  include ActiveModel::Model
  #通常のモデルのようにvalidationなどを使えるようにする

  include ActiveModel::Attributes
  #ActiveRecordのカラムのような属性を加えられるようにする

  #インスタンス変数を使えるようにする
  attr_accessor :name, :user_id, :post_id, :tag_id, :image


  #posts
  attribute :user_id, :integer
  attribute :title, :string
  attribute :reference_site, :string
  attribute :products_used, :string


  #processimages
  attribute :text1, :string
  attribute :text2, :string
  attribute :text3, :string
  attribute :text4, :string
  attribute :text5, :string
  attribute :text6, :string
  attribute :text7, :string
  attribute :text8, :string
  attribute :text9, :string
  attribute :text10, :string
  attribute :post_id, :integer
  attribute :image1
  attribute :image2
  attribute :image3
  attribute :image4
  attribute :image5
  attribute :image6
  attribute :image7
  attribute :image8
  attribute :image9
  attribute :image10

  #tag
  attribute :name

  #post_tag
  attribute :tag_id


  #バリデーション
  validates :title, presence: true
  validates :text1, presence: true
  validates :name, presence: true



 #保存処理
 def save_post
  if valid?
   post =Post.create(
     user_id: user_id,
     title: title,
     reference_site: reference_site,
     products_used: products_used)

   Processimage.create(
     user_id: user_id,
     text1: text1,
     text2: text2,
     text3: text3,
     text4: text4,
     text5: text5,
     text6: text6,
     text7: text7,
     text8: text8,
     text9: text9,
     text10: text10,
     post_id: post.id)

    #入力されたタグを空白で区切って配列化する
   tag_list = name.split(/[[:blank:]]+/).select(&:present?)

   tag_list.each do |new_tag|
     tag = Tag.find_or_create_by(name: new_tag)
     post.tags << tag
     tag.save
   end

   # 投稿画像の添付
   (1..10).each do |i|
     #image_field = send("image#{i}")
     #post.send("image#{i}").attach(image_field) if image_field.present?
   end

   return true
  else
   return false
  end
 end
end
