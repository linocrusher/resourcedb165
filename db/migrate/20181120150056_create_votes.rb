class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.string :type
      t.references :user, foreign_key: true
      t.references :resource, foreign_key: true

      t.timestamps
    end
  end
end
