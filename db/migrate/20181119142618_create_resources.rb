class CreateResources < ActiveRecord::Migration[5.1]
  def change
    create_table :resources do |t|
      t.float :trust
      t.text :text
      t.references :resource_thread, foreign_key: true

      t.timestamps
    end
  end
end
