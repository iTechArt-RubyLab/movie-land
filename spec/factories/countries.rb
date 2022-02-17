FactoryBot.define do
  factory :country do
    title { 'England' }

    trait :invalid_short_title do
      title { 'Ya' }
    end

    trait :invalid_long_title do
      title { 'YaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYaYa' }
    end
  end
end
