class AddResourceCountToResourceThreads < ActiveRecord::Migration[5.1]
  def change
  	add_column :resource_threads, :resource_count, :integer
  end
end
