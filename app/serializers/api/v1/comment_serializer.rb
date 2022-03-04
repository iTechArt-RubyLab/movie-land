module Api
  module V1
    class CommentSerializer < ActiveModel::Serializer
      attributes :id, :body
      belongs_to :user, serializer: UserSerializer
    end
  end
end
