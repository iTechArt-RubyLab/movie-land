module Api
  module V1
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :tagline, :trailer,
                 :release_date, :age_limit, :budget, :duration
    end
  end
end
