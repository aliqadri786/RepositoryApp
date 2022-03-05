class Repository < ApplicationRecord
  belongs_to :user

  validates :name, :description, presence: true

  has_and_belongs_to_many :users

  def self.search(keyword)
    where(["LOWER(name) like? OR LOWER(description) like?", "%#{keyword.downcase}%", "%#{keyword.downcase}%"])
  end
  

end
