module Api
  module V1
    class CountrySerializer < ActiveModel::Serializer
      attributes :id, :title
    end
  end
end
