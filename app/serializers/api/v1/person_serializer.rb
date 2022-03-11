module Api
  module V1
    class PersonSerializer < ActiveModel::Serializer
      attributes :id, :name, :surname, :birthday, :deathday, :married
      belongs_to :country, serializer: DictionarySerializer
      has_many :comments, serializer: CommentSerializer
    end
  end
end
