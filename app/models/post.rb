class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {minimum: 7}
  validates :body, presence: true

  def body_snippet(body)
    body.slice(0,100) + "..."
  end


end
