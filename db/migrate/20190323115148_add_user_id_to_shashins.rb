class AddUserIdToShashins < ActiveRecord::Migration[5.2]
  def change
   add_column :shashins, :user_id, :integer
  end
end
