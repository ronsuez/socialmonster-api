class AddIndexToPostDatum < ActiveRecord::Migration
  def change
  	add_index :post_data, :socialId, :unique => true
  end
end
