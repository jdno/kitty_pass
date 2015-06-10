class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.date :eol

      t.timestamps null: false
    end

    add_index :models, :name, unique: true
  end
end
