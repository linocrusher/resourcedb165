class Resource < ApplicationRecord
  belongs_to :resource_thread
  has_many :votes
end
