class CreatePostData < ActiveRecord::Migration
  def change
    create_table :post_data do |t|
      t.string :name
      t.string :origin
      t.integer :age
      t.string :image_url

      t.timestamps null: false
    end
  end
end
