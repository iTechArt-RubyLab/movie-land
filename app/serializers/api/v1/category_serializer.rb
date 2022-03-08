module Api
  module V1
    class CategorySerializer < ActiveModel::Serializer
      attributes :id, :name
      belongs_to :award, serializer: AwardSerializer
    end
  end
end
