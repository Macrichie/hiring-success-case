class CreateHiringUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :hiring_uploads do |t|

      t.timestamps
    end
  end
end
