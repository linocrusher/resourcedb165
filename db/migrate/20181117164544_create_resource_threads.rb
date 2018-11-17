class CreateResourceThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :resource_threads do |t|
      t.string :title
      t.text :description
      t.integer :resource_count, :default => 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
