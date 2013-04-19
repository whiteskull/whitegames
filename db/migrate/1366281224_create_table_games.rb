class CreateTableGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :content
      t.references :categoy

      t.timestamps
    end
    add_index :games, :categoy_id
  end
end
