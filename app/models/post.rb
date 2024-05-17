class Post < ApplicationRecord
  belongs_to :user

  has_many :processimages, dependent: :destroy
  #アソシエーション、postレコードを削除したときに紐づいたprocessimagesも削除

  accepts_nested_attributes_for :processimages, allow_destroy: true, reject_if: :all_blank

  validates :title, presence: true

end
