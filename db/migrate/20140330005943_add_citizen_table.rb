class AddCitizenTable < ActiveRecord::Migration
  def change
    create_table :citizens do |t|
      t.string :name
      t.belongs_to :rep
      t.timestamps
    end
  end
end
