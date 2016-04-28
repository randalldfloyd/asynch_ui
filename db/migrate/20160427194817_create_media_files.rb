class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.string :name
      t.string :store
      t.string :cache
      t.text :description

      t.timestamps null: false
    end
  end
end
