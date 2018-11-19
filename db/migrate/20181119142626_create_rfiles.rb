class CreateRfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :rfiles do |t|
      t.references :resource, foreign_key: true
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
