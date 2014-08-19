class AddColumnsToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :summerProject_title, :string
    add_column :applicants, :summerProject_contribution, :text
    add_column :applicants, :extras, :text
  end
end
