class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 20
      t.string :password, null: false, limit: 128
      t.datetime :date_created

      t.timestamps
    end
  end
end
