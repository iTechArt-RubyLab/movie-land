class TheMovieDb
  LIMIT = 650
  AGE_ADULT = 18
  MIN_AGE = 0
  MAX_AGE = 17

  def call
    genres_request
    companies_request
    people_request
    movies_request
    actors_request
    movie_staffs_request('director')
    movie_staffs_request('producer')
    movie_staffs_request('editor')
    movie_staffs_request('compositor')
    movie_staffs_request('artist')
    movie_staffs_request('screencaster')
  end

  private

  def genres_request
    genres = Tmdb::Genre.list
    Genre.create(genres['genres'])
  end

  def companies_request
    (1..LIMIT).each do |i|
      result = Tmdb::Company.detail(i)
      company = { name: result['name'] }
      Company.create(company)
    end
  end

  def people_request
    (1..LIMIT).each do |i|
      result = Tmdb::Person.detail(i)
      country = Country.find_or_create_by(name: result['place_of_birth']&.split&.last)
      country&.save
      person = { name: result['name']&.split&.first, surname: result['name']&.split&.last,
                 birthday: result['birthday'], deathday: result['deathday'], biography: result['biography'],
                 country_id: country[:id],
                 married: Faker::Boolean.boolean }
      Person.create(person).save
    end
  end

  def movies_request
    (1..LIMIT).each do |movie|
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
      movie.save
    end
  end

  def actors_request
    person = Person.all
    (1..Movie.count).each do |i|
      next unless person[i]&.biography&.include?('actor' || 'actress')

      actor = { actor_id: person[i].id, movie_id: Movie.find(i).id, role_name: Faker::Artist.name }
      ActorRole.create(actor)
    end
  end

  def movie_staffs_request(staff_type_name)
    person = Person.all
    (1..Movie.count).each do |i|
      if person[i]&.biography&.include? staff_type_name
        staff = { staff_id: person[i].id, movie_id: Movie.find(i).id, staff_type: staff_type_name }
        MovieStaff.create(staff)
      end
    end
  end

  def calculate_age_limit(adult)
    adult == true ? AGE_ADULT : Faker::Number.between(from: MIN_AGE, to: MAX_AGE)
  end

  def related_table_request(array, key, class_name)
    temp = []
    if array.nil?
      temp = []
    else
      (0..array.length - 1).each do |i|
        temp[i] = class_name.find_or_create_by(name: array[i][key])
      end
      temp
    end
  end
end
