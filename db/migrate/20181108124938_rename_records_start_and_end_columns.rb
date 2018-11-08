class RenameRecordsStartAndEndColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :records, :start, :start_date
    rename_column :records, :end, :end_date
  end
end
