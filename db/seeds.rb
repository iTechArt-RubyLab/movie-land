require 'factory_bot_rails'

FactoryBot.create_list(:country, 20)
FactoryBot.create_list(:company, 20)
FactoryBot.create_list(:genre, 20)
FactoryBot.create_list(:language, 20)
movies = FactoryBot.create_list(:movie, 20)
FactoryBot.create_list(:person, 20)
FactoryBot.create_list(:rating, 50)
FactoryBot.create(:user, :admin, email: 'admin@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create(:user, :redactor, email: 'redactor@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create(:user, :reviewer, email: 'reviewer@example.com', password: '123456', password_confirmation: '123456')
FactoryBot.create_list(:award, 20)
FactoryBot.create_list(:view_list, 20)
FactoryBot.create_list(:comment, 20)
FactoryBot.create_list(:comment, 20, :for_comment)
FactoryBot.create_list(:comment, 20, :for_person)
FactoryBot.create_list(:user, 30, :admin)
FactoryBot.create_list(:user, 30, :redactor)
FactoryBot.create_list(:user, 30, :reviewer)
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
 'Best action scene', 'Best operator performance', 'Best sound editing'].each do |category|
  awards.each do |award|
    categories << FactoryBot.create(:category, name: category, award: award)
  end
end
categories.each_with_index do |category, idx|
  FactoryBot.create_list(:movie_award, 30, category: category, movie: movies[idx])
end
