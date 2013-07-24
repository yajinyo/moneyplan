class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.date    :ymd,   :null => false
      t.string  :name,  :limit => 30
      t.text    :memo

      t.timestamps
    end
  end
end
