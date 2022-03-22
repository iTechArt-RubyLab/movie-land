require 'factory_bot_rails'

module Integration
  class TheMovieDb
    LIMIT = 500
    AGE_ADULT = 18
    MIN_AGE = 0
    MAX_AGE = 17
    AWARD_YEAR = 1
    EXISTS_MOVIE = LIMIT + 1
    PREMIERE_LIMIT = EXISTS_MOVIE + 20
    DAYS_IN_WEEK = 7
    NOMINATION_TYPES = %w[winner nominator].freeze
    DEFAULT_IMAGE_URL = 'http://image.tmdb.org/t/p/original'.freeze

    def call
      genres_request
      companies_request
      awards
      categories
      movies_request
      reviewers_functions
      premieres
    end

    private

    def genres_request
      genres = Tmdb::Genre.list
      Genre.create(genres['genres'])
    end

    def companies_request
      1.upto(LIMIT) do |company_id|
        company = Tmdb::Company.detail(company_id)
        Company.create({ name: company['name'] }) unless company.nil?
      end
    end

    def find_or_create_persons_country(persons_params)
      return if persons_params['place_of_birth'].nil?

      place_of_birth = persons_params['place_of_birth'].split.last
      country = Country.find_or_create_by(name: place_of_birth)
      country.id
    end

    def movie_actors(movie)
      movie_actors_params = Tmdb::Movie.casts(movie['id'])
      movie_actors_params&.each do |movie_actor|
        person_params = Tmdb::Person.detail(movie_actor['id'])
        next if person_params.nil?

        country_id = find_or_create_persons_country(person_params)
        begin
          person = Person.find_or_create_by(Helpers::TheMovieDbHelper::Person.new.params(
                                              person_params, country_id
                                            ))
          ActorRole.find_or_create_by(actor: person, movie: movie, role_name: movie_actor['character'])
        rescue StandardError
          next
        end
      end
    end

    def movie_staffs_request(movie, department, staff_type)
      movie_staffs_params = Tmdb::Movie.crew(movie['id'])
      movie_staffs_params&.each do |movie_staff|
        if movie_staff['department'].eql?(department)
          person_params = Tmdb::Person.detail(movie_staff['id'])
          next if person_params.nil?

          country_id = find_or_create_persons_country(person_params)
          begin
            person = Person.find_or_create_by(Helpers::TheMovieDbHelper::Person.new.params(
                                                person_params, country_id
                                              ))
            MovieStaff.find_or_create_by(staff: person, movie: movie, staff_type: staff_type)
          rescue StandardError
            next
          end
        end
      end
    end

    def movie_tags_request(movie)
      movie_tags_params = Tmdb::Movie.keywords(movie['id'])
      movie_tags_params['keywords']&.each do |movie_tag|
        tag = Tag.find_or_create_by(id: movie_tag['id'], name: movie_tag['name'])
        MoviesTag.find_or_create_by(movie: movie, tag: tag)
      end
    end

    def movies_request
      1.upto(LIMIT) do |movie|
        result = Tmdb::Movie.detail(movie)
        next if result['title'].nil?

        movie_values = { name: result['title'], age_limit: calculate_age_limit(result['adult']),
                         description: result['overview'], tagline: result['tagline'], trailer: Faker::Internet.url,
                         release_date: result['release_date'], budget: result['budget'],
                         duration: Faker::Number.number(digits: 3) }
        movie = Movie.create(movie_values)
        movie.remote_poster_url = "#{DEFAULT_IMAGE_URL}#{result['poster_path']}"
        movie.languages.push(related_table_request(result['spoken_languages'], 'english_name', Language))
        movie.genres.push(related_table_request(result['genres'], 'name', Genre))
        movie.companies.push(related_table_request(result['production_companies'], 'name', Company))
        movie.countries.push(related_table_request(result['production_countries'], 'name', Country))
        movie_actors(movie)
        movie_staffs_request(movie, 'Directing', 'director')
        movie_staffs_request(movie, 'Production', 'producer')
        movie_staffs_request(movie, 'Editing', 'editor')
        movie_staffs_request(movie, 'Writing', 'screencaster')
        movie_staffs_request(movie, 'Art', 'artist')
        movie_staffs_request(movie, 'Sound', 'compositor')
        movie_tags_request(movie)
        movie_award = MovieAward.create(nomination_type: NOMINATION_TYPES.sample, category: Category.all.sample,
                                        delivery_year: movie['release_date'].year + AWARD_YEAR, movie_id: movie['id'])
        movie_award.people.push(Person.all.sample) if Person.exists?
        movie.save
      end
    end

    def calculate_age_limit(adult)
      adult == true ? AGE_ADULT : Faker::Number.between(from: MIN_AGE, to: MAX_AGE)
    end

    def related_table_request(array, key, class_name)
      result = []
      unless array.nil?
        0.upto(array.length - 1) do |array_element|
          result.push(class_name.find_or_create_by(name: array[array_element][key]))
        end
      end
      result
    end

    def awards
      ['Oscar', 'Golden globe', 'British akademy',
       'Actors Guild', 'Nika', 'Golden Eagle',
       'Goya', 'Emmy', 'Cesar', 'Saturn'].each do |award|
        FactoryBot.create(:award, name: award)
      end
    end

    def categories
      ['Best movie', 'Best sound', 'Best adapted screenplay', 'The best music',
       'Best cast', 'Best editing', 'Best original soundtrack', 'Best screenplay',
       'Best costumes', 'Best visual effects', 'Best makeup', 'Best scenery',
       'Best action scene', 'Best operator performance', 'Best sound editing', 'Best director',
       'Best actor', 'Best supporting actor', 'Best actress', 'Best supporting actress'].each do |category|
        3.times { FactoryBot.create(:category, name: category, award: Award.all.sample) }
      end
    end

    def reviewers_functions
      User.where(role: Role.find_by(name: 'reviewer')).each do |reviewer|
        FactoryBot.create(:view_list, user: reviewer, movie: Movie.all.sample)
        FactoryBot.create(:rating, user: reviewer, movie: Movie.all.sample)
        FactoryBot.create(:comment, user: reviewer, commentable: Movie.all.sample)
        FactoryBot.create(:comment, :for_person, user: reviewer, commentable: Person.all.sample)
      end
    end

    def premieres
      EXISTS_MOVIE.upto(PREMIERE_LIMIT) do |movie|
        result = Tmdb::Movie.detail(movie)
        next if result['title'].nil?

        movie_values = { name: result['title'], age_limit: calculate_age_limit(result['adult']),
                         description: result['overview'], tagline: result['tagline'], trailer: Faker::Internet.url,
                         release_date: Faker::Date.between(from: Time.zone.today, to: Time.zone.today + DAYS_IN_WEEK),
                         budget: result['budget'],
                         duration: Faker::Number.number(digits: 3) }
        Movie.create(movie_values)
      end
    end
  end
end
