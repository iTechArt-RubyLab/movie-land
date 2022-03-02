module Api
  module V1
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :tagline, :trailer,
                 :release_date, :age_limit, :budget, :duration,
                 :poster
      has_many :companies, serializer: DictionarySerializer
      has_many :countries, serializer: DictionarySerializer
      has_many :genres, serializer: DictionarySerializer
      has_many :languages, serializer: DictionarySerializer
      has_many :tags, serializer: DictionarySerializer
      has_many :ratings, serializer: RatingSerializer
      has_many :view_lists, serializer: ViewListSerializer
    end
  end
end
