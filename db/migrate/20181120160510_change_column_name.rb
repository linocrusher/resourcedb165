class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :votes, :type, :value
  end
end
