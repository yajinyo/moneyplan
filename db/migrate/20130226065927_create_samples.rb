class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :user
      t.integer :item

      t.timestamps
    end
  end
end
