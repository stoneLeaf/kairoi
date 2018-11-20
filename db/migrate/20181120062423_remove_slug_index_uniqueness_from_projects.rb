class RemoveSlugIndexUniquenessFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_index :projects, :slug
    add_index :projects, :slug
  end
end
