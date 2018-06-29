class Article < ApplicationRecord


    has_many :favourites
    belongs_to :writer, :source => 'User'
    has_many :likers :through => :favourites, :source => 'User'
end
