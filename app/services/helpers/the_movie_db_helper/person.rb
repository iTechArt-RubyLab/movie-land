module Helpers
  module TheMovieDbHelper
    class Person
      def params(person, country_id)
        { id: person['id'], name: first_name(person), surname: second_name(person),
          birthday: person['birthday'], deathday: person['deathday'], biography: person['biography'],
          country_id: country_id,
          married: Faker::Boolean.boolean }
      end

      private

      def first_name(person)
        person['name'].split.first
      end

      def second_name(person)
        person['name'].split.last
      end
    end
  end
end
