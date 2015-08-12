class CreateBirthplaces < ActiveRecord::Migration
  def change
    create_table :birthplaces do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
