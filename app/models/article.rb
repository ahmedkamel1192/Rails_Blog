class Article < ApplicationRecord

    has_many :favourites
    belongs_to :user
    has_many :likers, :through => :favourites, :source => :user
    validates :title,:content, presence: true
end
