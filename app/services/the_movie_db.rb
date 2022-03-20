class TheMovieDb
  LIMIT = 250
  AGE_ADULT = 18
  MIN_AGE = 0
  MAX_AGE = 17

  def call
    genres_request
    companies_request
    movies_request
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
    if persons_params['place_of_birth'].present?
      place_of_birth = persons_params['place_of_birth'].split.last
      country = Country.find_or_create_by(name: place_of_birth)
      country.id
    end
    nil
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
        retry
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
          retry
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
      movie_values = { name: result['title'], age_limit: calculate_age_limit(result['adult']),
                       description: result['overview'], tagline: result['tagline'], trailer: Faker::Internet.url,
                       release_date: result['release_date'], budget: result['budget'],
                       duration: Faker::Number.number(digits: 3), poster: result['poster_path'] }
      movie = Movie.create(movie_values)
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
        result[array_element] = class_name.find_or_create_by(name: array[array_element][key])
      end
    end
    result
  end
end
