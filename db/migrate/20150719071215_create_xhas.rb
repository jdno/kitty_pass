class CreateXHAs < ActiveRecord::Migration
  def change
    create_table :xhas do |t|
      t.belongs_to :master
      t.belongs_to

      t.timestamps null: false
    end

    add_index :xhas, [:master_id, :slave_id]
  end
end
