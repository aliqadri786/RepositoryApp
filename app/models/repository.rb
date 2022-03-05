class Repository < ApplicationRecord
  belongs_to :user

  validates :name, :description, presence: true
  validates_uniqueness_of :name
  validates_length_of :description, minimum: 5, maximum: 100

  has_and_belongs_to_many :users

  def self.search(keyword)
    where(["LOWER(name) like? OR LOWER(description) like?", "%#{keyword.downcase}%", "%#{keyword.downcase}%"])
  end
  
end
