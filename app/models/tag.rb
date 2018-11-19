class Tag < ApplicationRecord
  belongs_to :resource_thread
  belongs_to :keyword
end
