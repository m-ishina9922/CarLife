class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :post, dependent: :destroy

  #プロフィール画像
  has_one_attached :profile_image

   def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  #愛車プロフィール画像


  def car_profile_image
    unless car_profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      car_profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    car_profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
