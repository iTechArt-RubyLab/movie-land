module Api
  module V1
    class MovieAwardSerializer < ActiveModel::Serializer
      attributes :id, :name, :delivery_year
      belongs_to :movie, serializer: MovieSerializer
      belongs_to :award, serializer: AwardSerializer
    end
  end
end
