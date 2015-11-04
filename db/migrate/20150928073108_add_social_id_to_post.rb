class AddSocialIdToPost < ActiveRecord::Migration
  def change
    add_column :post_data, :socialId, :String
  end
end
