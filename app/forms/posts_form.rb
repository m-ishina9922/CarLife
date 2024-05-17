class PostsForm
  include ActiveModel::Model
  #通常のモデルのようにvalidationなどを使えるようにする

  include ActiveModel::Attributes
  #ActiveRecordのカラムのような属性を加えられるようにする

  validates :title, presence: true
  validates :text, presence: true




  def save
      return false if invalid?

      ActiveRecord::Base.transaction do
        post = Post.create!(title: title, reference_site: reference_site, products_used: products_used)
        process_image = ProcessImage.create!(text: text)


        post.process_images << process_image

      end

      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
      false
  end

  def posts_form_params
    params.require(:posts_form).permit(:title, :reference_site, :products_used, :text)
  end

end