class AddRepTable < ActiveRecord::Migration
  def change
    create_table :reps do |t|
      t.string :name
      t.belongs_to :bill
      t.timestamps
    end
  end
end
