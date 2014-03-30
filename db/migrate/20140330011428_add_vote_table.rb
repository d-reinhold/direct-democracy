class AddVoteTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :bill
      t.belongs_to :citizen
      t.belongs_to :rep
      t.boolean :value
      t.timestamps
    end
  end
end
