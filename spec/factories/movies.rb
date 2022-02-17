FactoryBot.define do
  factory :movie do
    title { 'MyString' }
    description { 'MyText' }
    tagline { 'MyString' }
    trailer { 'MyString' }
    release_date { '2022-02-17' }
    poster { nil }
    image { nil }
    age_limit { 1 }
    budget { '' }
    category { nil }
    duration { 1 }
    season { nil }
  end
end
