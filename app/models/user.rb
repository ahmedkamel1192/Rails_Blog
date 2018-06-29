class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates_format_of :email, :with =>/.+@[a-zA-Z]+\..+/i	
end
