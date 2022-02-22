module Api
  module V1
    class RatingSerializer < ActiveModel::Serializer
      attributes :id, :body, :rating
      belongs_to :user, serializer: UserSerializer
      belongs_to :movie, serializer: MovieSerializer
    end
  end
end
