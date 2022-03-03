# == Schema Information
#
# Table name: view_lists
#
#  id              :bigint           not null, primary key
#  watching_status :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  movie_id        :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_view_lists_on_movie_id              (movie_id)
#  index_view_lists_on_user_id               (user_id)
#  index_view_lists_on_user_id_and_movie_id  (user_id,movie_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :view_list do
    association :user
    association :movie

    trait :will_watch_status do
      watching_status { :will_watch }
    end

    trait :now_watching_status do
      watching_status { :watching }
    end

    trait :already_viewed_status do
      watching_status { :viewed }
    end
  end
end
