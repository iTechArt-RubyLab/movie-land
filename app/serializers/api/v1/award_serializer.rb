module Api
  module V1
    class AwardSerializer < ActiveModel::Serializer
      attributes :id, :name
      belongs_to :country, serializer: DictionarySerializer
      has_many :categories, serializer: DictionarySerializer
    end
  end
end
