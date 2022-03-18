module Search
  module Results
    module ActorRoles
      class Builder < BaseBuilder
        def autocomplete_hint
          "#{record.role_name}, #{record.actor.name}, #{record.movie.name}"
        end
      end
    end
  end
end
