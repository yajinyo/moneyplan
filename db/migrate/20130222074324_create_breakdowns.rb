class CreateBreakdowns < ActiveRecord::Migration
  def change

    create_table :breakdowns do |t|
      t.xml :item
      t.timestamps
    end

=begin
    create_table :breakdowns, :id => false do |t|
      t.integer "id", :null => false
      t.xml "item"
      t.timestamps
    end
=end
  end
end
