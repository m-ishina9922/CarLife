class CreateProcessimages < ActiveRecord::Migration[6.1]
  def change
    create_table :processimages do |t|

      t.integer :post_id
      t.string :text
      t.integer :user_id
      t.timestamps
    end
  end
end
