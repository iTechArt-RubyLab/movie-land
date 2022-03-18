shared_context 'with unique cleaner' do
  before do
    Faker::Movie.unique.clear
    Faker::UniqueGenerator.clear
  end
end
