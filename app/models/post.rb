class Post < ApplicationRecord
  belongs_to :user
  
  has_many :processimages, dependent: :destroy 
  #アソシエーション、postレコードを削除したときに紐づいたprocessimagesも削除

  validates :title, presence: true

end
