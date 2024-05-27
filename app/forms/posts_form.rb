class PostsForm
  include ActiveModel::Model
  #通常のモデルのようにvalidationなどを使えるようにする

  include ActiveModel::Attributes
  #ActiveRecordのカラムのような属性を加えられるようにする

  #インスタンス変数を使えるようにする
  attr_accessor :name, :post_id, :tag_id

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

  #tag
  attribute :name

  #post_tag
  attribute :tag_id


  #バリデーション
  validates :title, presence: true
  validates :text1, presence: true



  #レコード保存の処理
  def save_post
    post = Post.create(user_id: user_id, title: title, reference_site: reference_site, products_used: products_used)
    processimage = Processimage.create(user_id: user_id, text1: text1, text2: text2, text3: text3, text4: text4, text5: text5, text6: text6, text7: text7, text8: text8, text9: text9, text10: text10, post_id: post.id)

    tag = Tag.create(name: name)
    #入力されたタグを空白で区切って配列化する
    tag_list = tag_id.split(/[[:blank:]]+/).select(&:present?)
    #入力されたタグが新規タグか既存のタグかを判別
    tag_list.each do |tag_name|
      @tag = Tag.where(name: tag_name).first_or_initialize
      @tag. save
    end

    true
  end
end
