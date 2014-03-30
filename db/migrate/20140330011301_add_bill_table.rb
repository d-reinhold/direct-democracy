class AddBillTable < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name
      t.string :link
      t.belongs_to :bill
      t.belongs_to :rep
      t.timestamps
    end
  end
end
