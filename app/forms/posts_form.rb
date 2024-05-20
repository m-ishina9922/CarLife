class PostsForm
  include ActiveModel::Model
  #通常のモデルのようにvalidationなどを使えるようにする

  include ActiveModel::Attributes
  #ActiveRecordのカラムのような属性を加えられるようにする

  attr_accessor :title, :reference_site, :products_used, :text, :name


  validates :title, presence: true
  validates :text, presence: true




  def save_post
        post = Post.create(title: title, reference_site: reference_site, products_used: products_used)
        process_image = Processimage.create(text: text)

  end

end