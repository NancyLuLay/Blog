class Post < ApplicationRecord
  attr_accessor :tweet_it

  has_many :comments, dependent: :destroy

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  belongs_to :user
  validates :title, presence: true, length: {minimum: 7}, uniqueness: {scope: :body}
  validates :body, presence: true

  def favourite_for(user)
    favourites.find_by_user_id user
  end

  def body_snippet(body)
    body.slice(0,100) + "..."
  end


end
