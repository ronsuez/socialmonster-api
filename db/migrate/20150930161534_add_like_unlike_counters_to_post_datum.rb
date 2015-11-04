class AddLikeUnlikeCountersToPostDatum < ActiveRecord::Migration
  def change
    add_column :post_data, :like, :Integer
    add_column :post_data, :unlike, :Integer
    PostDatum.all.each do |post|
    	post.update_attributes(:unlike => 0, :like => 0)
  	end
  end
end
