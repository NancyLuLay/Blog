class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :comments, :favourites, :user

  has_many :comments
  has_many :favourites

  def title
    object.title.titleize
  end

  def created_at
    object.created_at.to_formatted_s(:short)
  end

  def favourites
    object.favourites.count()
  end

  def user
    current_user.first_name
  end

end
