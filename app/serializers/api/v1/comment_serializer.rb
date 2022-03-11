module Api
  module V1
    class CommentSerializer < ActiveModel::Serializer
      attributes :id, :body
      belongs_to :user, serializer: UserSerializer
      has_many :comments, serializer: CommentSerializer
    end
  end
end
