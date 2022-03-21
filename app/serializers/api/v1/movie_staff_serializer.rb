module Api
  module V1
    class MovieStaffSerializer < ActiveModel::Serializer
      attributes :id, :staff_type, :staff
      belongs_to :staff, serializer: PersonSerializer
    end
  end
end
