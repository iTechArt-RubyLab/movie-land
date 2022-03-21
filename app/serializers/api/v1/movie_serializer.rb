module Api
  module V1
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :tagline, :duration,
                 :release_date, :average_rating, :age_limit, :budget,
                 :trailer, :poster, :images
      has_many :genres, serializer: DictionarySerializer
      has_many :countries, serializer: DictionarySerializer
      has_many :companies, serializer: DictionarySerializer
      has_many :actor_roles, serializer: ActorRoleSerializer
      has_many :movie_staffs, serializer: MovieStaffSerializer
      has_many :languages, serializer: DictionarySerializer
      has_many :tags, serializer: DictionarySerializer
      has_many :comments, serializer: CommentSerializer
      has_many :movie_awards, serializer: MovieAwardSerializer
    end
  end
end
