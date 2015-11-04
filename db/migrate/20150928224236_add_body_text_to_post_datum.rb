class AddBodyTextToPostDatum < ActiveRecord::Migration
  def change
    add_column :post_data, :body, :text
  end
end
