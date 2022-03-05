class User < ApplicationRecord
    validates :first_name, :last_name, :email, presence: true

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    def full_name
        "#{first_name} #{last_name}"
    end
end
