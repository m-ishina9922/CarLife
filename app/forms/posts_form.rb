class PostsForm
  include ActiveModel::Model
  #通常のモデルのようにvalidationなどを使えるようにする

  include ActiveModel::Attributes
  #ActiveRecordのカラムのような属性を加えられるようにする

  #posts
  attribute :user_id, :integer
  attribute :title, :string
  attribute :reference_site, :string
  attribute :products_used, :string


  #processimages
  attribute :text, :string
  attribute :post_id, :integer

  #tags



  #バリデーション
  validates :title, presence: true
  validates :text, presence: true



  #レコード保存の処理
  def save_post
    post = Post.create(user_id: user_id, title: title, reference_site: reference_site, products_used: products_used)
    processimage = Processimage.create(user_id: user_id, text: text, post_id: post.id)
  end

end
