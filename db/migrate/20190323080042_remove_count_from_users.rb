class RemoveCountFromUsers < ActiveRecord::Migration[5.2]
  def change
   remove_column :users, :favorites_count 
  end
end
