class CreateIdolTeams < ActiveRecord::Migration
  def change
    create_table :idol_teams do |t|
      t.references :idol, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
