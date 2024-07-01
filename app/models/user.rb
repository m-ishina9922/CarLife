class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :processimages, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #プロフィール画像
  has_one_attached :profile_image
  #愛車プロフィール画像
  has_many_attached :car_images


   def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [50, 50]).processed
  end

    def get_car_images
    unless car_images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      car_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    car_images.variant(resize_to_limit: [100, 100]).processed
  end

  #退会済みのユーザーが同じアカウントでログインできないようにする
   def active_for_authentication?
     super && (is_valid == true)
   end



 #ゲストログイン機能
   def self.guest
     find_or_create_by!(email: 'guest@example.com') do |user|
       user.password = SecureRandom.urlsafe_base64
       user.name = "ゲストさん"
     end
   end

 #検索方法の条件分岐
 #LIKEによるあいまい検索の構文を使用
   def self.looks(search, word)
      @user = User.where("name LIKE?", "%#{word}%")
   end



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
