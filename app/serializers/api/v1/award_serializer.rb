module Api
  module V1
    class AwardSerializer < ActiveModel::Serializer
      attributes :id, :name
      belongs_to :country, serializer: DictionarySerializer
    end
  end
end
