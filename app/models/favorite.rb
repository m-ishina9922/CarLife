class Favorite < ApplicationRecord

  belongs_to :post
  belongs_to :user

  #いいねが重複しないようにするバリデーション
  validates :user_id, uniqueness: {scope: :post_id}
end
