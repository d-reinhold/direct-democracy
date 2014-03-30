class AddResultToBill < ActiveRecord::Migration
  def change
    add_column :bills, :result, :string
    add_column :bills, :passed, :boolean
  end
end
