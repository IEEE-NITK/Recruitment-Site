class AddColumnToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :branch, :string
  end
end
