class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.string :title
      t.integer :processimage
      t.string :reference_site
      t.string :products_used


      t.timestamps
    end
  end
end
