class Post < ApplicationRecord
  belongs_to :user
  has_many :processimages,  dependent: :destroy

  validates :title, presence: true

end
