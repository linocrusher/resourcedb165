class AddInstancesToKeywords < ActiveRecord::Migration[5.1]
  def change
  	add_column :keywords, :instances, :integer
  end
end
