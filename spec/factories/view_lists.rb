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
#  index_view_lists_on_movie_id                      (movie_id)
#  index_view_lists_on_user_id                       (user_id)
#  index_view_lists_on_watching_status_and_movie_id  (watching_status,movie_id) UNIQUE
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
  end
end
