class AddIndexToRecords < ActiveRecord::Migration[5.2]
  def change
    add_index :records, [:user_id, :project_id, :start], order: {start: :desc}
  end
end
