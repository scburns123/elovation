class Release100 < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.string :name, :null => false

      t.timestamps
    end

    create_table :games do |t|
      t.string :name, :null => false

      t.timestamps
    end

    create_table :results do |t|
      t.integer :winner_id, :null => false
      t.integer :game_id, :null => false

      t.timestamps
    end

    create_table :players_results do |t|
      t.integer :player_id, :null => false
      t.integer :result_id, :null => false
    end
  end

  def down
  end
end