class User < ApplicationRecord
    has_secure_password
    validates_presence_of :password_digest
    validates :email, presence: true, uniqueness: true
    validates_format_of :email, :with =>/.+@[a-zA-Z]+\..+/i	
   
    has_many :favourites
    has_many :favourite_articles, :through => :favourites, :source => :article
    has_many :articles

    #Has_many | Has_many — Self Join Table
    has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
    has_many :followers, through: :follower_follows, source: :follower
   

    has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
    has_many :followees, through: :followee_follows, source: :followee
    
end
