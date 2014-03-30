class AddTagTable < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :citizens_tags do |t|
      t.belongs_to :tag
      t.belongs_to :citizen
    end

    create_table :bills_tags do |t|
      t.belongs_to :bill
      t.belongs_to :tag
    end
  end
end
