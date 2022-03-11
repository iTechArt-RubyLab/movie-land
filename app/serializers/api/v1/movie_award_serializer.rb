module Api
  module V1
    class MovieAwardSerializer < ActiveModel::Serializer
      attributes :id, :nomination_type, :delivery_year
      belongs_to :movie, serializer: MovieSerializer
      belongs_to :category, serializer: CategorySerializer
      has_many :people, serializer: PersonSerializer
    end
  end
end
