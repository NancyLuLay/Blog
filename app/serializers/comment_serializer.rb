class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
end
