class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.text :name
      t.text :image
      t.text :link
      t.string :category
      t.integer :rank

      t.timestamps
    end
  end
end
