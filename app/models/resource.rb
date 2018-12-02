class Resource < ApplicationRecord
  belongs_to :resource_thread
  belongs_to :user
  has_many :votes
end
