class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.belongs_to :resource_thread, foreign_key: true
      t.belongs_to :keyword, foreign_key: true

      t.timestamps
    end
  end
end
