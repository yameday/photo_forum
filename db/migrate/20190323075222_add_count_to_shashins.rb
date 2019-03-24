class AddCountToShashins < ActiveRecord::Migration[5.2]
  def change
   add_column :shashins, :favorites_count, :integer, default: 0 

    Shashin.pluck(:id).each do |i|          
      Shashin.reset_counters(i, :favorites) 
    end
  end
end
