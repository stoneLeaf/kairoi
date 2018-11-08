class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.datetime :start
      t.datetime :end
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
