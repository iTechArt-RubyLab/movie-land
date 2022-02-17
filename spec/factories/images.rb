FactoryBot.define do
  factory :image do
    link { 'https://image.posterlounge.com/images/l/1901278.jpg' }

    trait :invalid_link do
      link { 'name.png#3r3' }
    end
  end
end
