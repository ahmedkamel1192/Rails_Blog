class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates_format_of :email, :with =>/.+@[a-zA-Z]+\..+/i	
   
    has_many :favourites
    has_many :favourite_articles, :through => :favourites, :source => :article
    has_many :written_articles , :source => :article
  
end
