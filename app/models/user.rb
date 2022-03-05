class User < ApplicationRecord
    validates :first_name, :last_name, :email, presence: true

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    has_and_belongs_to_many :repositories

    has_many :repositories, dependent: :destroy

    def full_name
        "#{first_name} #{last_name}"
    end
end
