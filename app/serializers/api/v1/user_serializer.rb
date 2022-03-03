module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :username,
                 :name, :surname, :birthday
      has_many :ratings, serializer: RatingSerializer
      has_many :view_lists, serializer: ViewListSerializer
    end
  end
end
