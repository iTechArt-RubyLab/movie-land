# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :role do
    name { Faker::Company.unique.profession }

    trait :admin do
      name { 'admin' }
    end

    trait :redactor do
      name { 'redactor' }
    end

    trait :reviewer do
      name { 'reviewer' }
    end
  end
end
