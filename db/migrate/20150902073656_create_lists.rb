class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.text :url

      t.timestamps null: false
    end
  end
end
