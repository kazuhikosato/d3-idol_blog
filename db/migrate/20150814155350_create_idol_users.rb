class CreateIdolUsers < ActiveRecord::Migration
  def change
    create_table :idol_users do |t|
      t.references :idol, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
