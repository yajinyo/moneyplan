class DropSamples < ActiveRecord::Migration
  def up
    drop_table :samples
  end

  def down
    create_table :samples do |t|
      t.string :user
      t.integer :item

      t.timestamps
    end
  end
end