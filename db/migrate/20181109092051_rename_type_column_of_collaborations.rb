class RenameTypeColumnOfCollaborations < ActiveRecord::Migration[5.2]
  def change
    rename_column :collaborations, :type, :nature
  end
end
