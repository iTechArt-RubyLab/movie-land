require 'factory_bot_rails'

FactoryBot.create_list(:country, 20)
FactoryBot.create_list(:company, 20)
FactoryBot.create_list(:genre, 20)
FactoryBot.create_list(:language, 20)
FactoryBot.create(:permission, :admin)
FactoryBot.create(:permission, :redactor)
FactoryBot.create(:permission, :reviewer)

movies = FactoryBot.create_list(:movie, 60)
movies.each do |movie|
  movie.countries << Country.all.sample(2)
  movie.companies << Company.all.sample(2)
  movie.genres << Genre.all.sample(2)
  movie.languages << Language.all.sample(2)
  movie.comments << FactoryBot.create(:comment, commentable_type: Movie, commentable_id: movie.id)
end

people = FactoryBot.create_list(:person, 20)
people.each do |person|
  person.comments << FactoryBot.create(:comment, :for_person, commentable_type: Person, commentable_id: person.id)
end

FactoryBot.create(:user, :admin, email: 'admin@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create(:user, :redactor, email: 'redactor@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create(:user, :reviewer, email: 'reviewer@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create_list(:user, 30, :admin)
FactoryBot.create_list(:user, 30, :redactor)

reviewers = FactoryBot.create_list(:user, 30, :reviewer)
reviewers.each do |reviewer|
  FactoryBot.create(:view_list, user: reviewer, movie: Movie.all.sample)
  FactoryBot.create(:rating, user: reviewer, movie: Movie.all.sample)
end

awards = []
['Oscar', 'Golden globe', 'British akademy',
 'Actors Guild', 'Nika', 'Golden Eagle',
 'Goya', 'Emmy', 'Cesar', 'Saturn'].each do |award|
  awards << FactoryBot.create(:award, name: award)
end

categories = []
['Best movie', 'Best sound', 'Best adapted screenplay', 'The best music',
 'Best cast', 'Best editing', 'Best original soundtrack', 'Best screenplay',
 'Best costumes', 'Best visual effects', 'Best makeup', 'Best scenery',
 'Best action scene', 'Best operator performance', 'Best sound editing', 'Best director',
 'Best actor', 'Best supporting actor', 'Best actress', 'Best supporting actress'].each do |category|
  3.times { categories << FactoryBot.create(:category, name: category, award: awards.sample) }
end

categories.each_with_index do |category, idx|
  FactoryBot.create(:movie_award, category: category, movie: movies[idx])
end
