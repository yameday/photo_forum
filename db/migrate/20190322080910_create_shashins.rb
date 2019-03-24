class CreateShashins < ActiveRecord::Migration[5.2]
  def change
    create_table :shashins do |t|
      t.string "title"
      t.text "description"
      t.string "file_location"
      t.timestamps
    end
  end
end
