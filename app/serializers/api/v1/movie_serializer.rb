module Api
  module V1
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :tagline, :trailer,
                 :release_date, :age_limit, :budget, :duration
      has_many :companies, serializer: DictionarySerializer
      has_many :countries, serializer: DictionarySerializer
      has_many :genres, serializer: DictionarySerializer
      has_many :languages, serializer: DictionarySerializer
    end
  end
end
