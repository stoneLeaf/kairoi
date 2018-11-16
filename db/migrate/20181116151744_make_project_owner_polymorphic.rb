class MakeProjectOwnerPolymorphic < ActiveRecord::Migration[5.2]
  def change
    remove_reference :projects, :owner, foreign_key: { to_table: :users }
    add_reference :projects, :owner, polymorphic: true, index: true
  end
end
