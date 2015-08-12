class CreateIdols < ActiveRecord::Migration
  def change
    create_table :idols do |t|
      t.string :name
      t.string :kana
      t.string :image_url
      t.date :birthday
      t.references :birthplace, index: true, foreign_key: true
      t.string :url

      t.timestamps null: false
    end
  end
end
