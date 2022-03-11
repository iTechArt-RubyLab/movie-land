# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :comment do
    body { Faker::GreekPhilosophers.quote }
    association :user
    association :commentable, factory: :movie

    trait :for_comment do
      association :commentable, factory: :comment
    end

    trait :for_person do
      association :commentable, factory: :person
    end

    trait :invalid_long_body do
      body { Faker::Lorem.characters(number: 2001) }
    end

    trait :invalid_short_body do
      body { Faker::Lorem.characters(number: 1) }
    end
  end
end
