class Folder < ApplicationRecord
  belongs_to :resource_thread
  has_many :rfiles
  has_many :resources, through: :rfiles
end
