class AddSummaryToBill < ActiveRecord::Migration
  def change
    add_column :bills, :summary, :string
  end
end
