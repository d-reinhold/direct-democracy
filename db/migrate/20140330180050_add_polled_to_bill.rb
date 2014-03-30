class AddPolledToBill < ActiveRecord::Migration
  def change
    add_column :bills, :has_polled, :boolean, default: false
  end
end
