class CreateHirings < ActiveRecord::Migration[5.2]
  def change
    create_table :hirings do |t|
      t.string :name
      t.integer :year
      t.references :city, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
