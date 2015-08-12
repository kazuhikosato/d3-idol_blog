class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :url, limit: 500
      t.datetime :datetime
      t.integer :access, default:0
      t.references :idol, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
