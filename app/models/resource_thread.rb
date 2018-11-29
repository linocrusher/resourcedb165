class ResourceThread < ApplicationRecord
  belongs_to :user
  has_many :tags
  has_many :keywords, through: :tags
  has_many :folders
  has_many :resources
  validates :title, presence: true, length: { maximum: 100 }

  def all_keywords=(names)
  	self.keywords = names.split(",").map do |name|
  		Keyword.where(text: name.strip).first_or_create!
  	end
  end

  def all_keywords
  	self.keywords.map(&:text).join(", ")
  end
end
