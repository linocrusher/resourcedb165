class Keyword < ApplicationRecord
	has_many :tags
	has_many :resource_threads, through: :tags
end
