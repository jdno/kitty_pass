class CreateXHA < ActiveRecord::Migration
  def change
    create_table :xha do |t|
      t.belongs_to :master
      t.belongs_to :slave

      t.timestamps null: false
    end

    add_index :xha, [:master_id, :slave_id]
  end
end
