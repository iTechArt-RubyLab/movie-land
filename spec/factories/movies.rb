# == Schema Information
#
# Table name: movies
#
#  id                :bigint           not null, primary key
#  age_limit         :integer
#  budget            :bigint
#  description       :text
#  duration          :integer
#  images            :string           default([]), is an Array
#  name              :string
#  number_of_ratings :integer          default(0)
#  poster            :string
#  release_date      :date
#  tagline           :string
#  total_score       :integer          default(0)
#  trailer           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_movies_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :movie do
    name { Faker::Movie.unique.title }
    description { Faker::Lorem.sentence(word_count: 5) }
    tagline { Faker::Movie.quote }
    trailer { Faker::Internet.url }
    release_date { Faker::Date.between(from: '2022-03-02', to: '2022-04-01') }
    age_limit { Faker::Number.between(from: 1, to: 100) }
    budget { Faker::Number.number(digits: 5) }
    duration { Faker::Number.number(digits: 3) }
    poster { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/posters/test.jpg')) }
    images do
      [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/test.jpg'), 'spec/fixtures/images/test.jpg')]
    end

    trait :invalid_long_name do
      name { Faker::Lorem.characters(number: 301) }
    end

    trait :invalid_short_name do
      name { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_long_description do
      description { Faker::Lorem.characters(number: 501) }
    end

    trait :invalid_short_description do
      description { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_long_tagline do
      tagline { Faker::Lorem.characters(number: 301) }
    end

    trait :invalid_short_tagline do
      tagline { Faker::Lorem.characters(number: 1) }
    end

    trait :invalid_trailer_url do
      trailer { Faker::Lorem.characters(number: 5) }
    end

    trait :invalid_big_age_limit do
      age_limit { Faker::Number.between(from: 101, to: 200) }
    end

    trait :invalid_small_age_limit do
      age_limit { Faker::Number.negative }
    end

    trait :invalid_decimal_age_limit do
      age_limit { Faker::Number.decimal(l_digits: 2) }
    end

    trait :invalid_small_budget do
      budget { Faker::Number.negative }
    end

    trait :invalid_decimal_budget do
      budget { Faker::Number.decimal(l_digits: 2) }
    end

    trait :invalid_small_duration do
      duration { Faker::Number.negative }
    end

    trait :invalid_decimal_duration do
      duration { Faker::Number.decimal(l_digits: 2) }
    end

    trait :valid_ratings_attributes do
      total_score { 2 }
      number_of_ratings { 18 }
    end

    trait :zero_ratings_attributes do
      total_score { 0 }
      number_of_ratings { 0 }
    end

    trait :invalid_poster_format do
      poster { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/posters/test.svg')) }
    end

    trait :invalid_images_format do
      images do
        [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/test.svg'),
                                      'spec/fixtures/images/test.svg')]
      end
    end
  end
end
