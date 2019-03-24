class RenameLikeIdInFavorites < ActiveRecord::Migration[5.2]
  def change
   rename_column :favorites, :like_id, :shashin_id
  end
end
