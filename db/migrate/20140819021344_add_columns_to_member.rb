class AddColumnsToMember < ActiveRecord::Migration
  def change
    add_column :members, :contact, :string
    add_column :members, :branch, :string
  end
end
