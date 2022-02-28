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
class ViewList < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :movie

  validates :watching_status, uniqueness: { scope: :movie_id, message: 'This movie has already been added to your viewlist.' }

  aasm column: :watching_status do
    state :will_watch
    state :watching
    state :viewed

    event :will_watching do
      transitions from: %i[watching viewed], to: :will_watch
    end

    event :now_watching do
      transitions from: %i[viewed will_watch], to: :watching
    end

    event :already_viewed do
      transitions from: %i[will_watch watching], to: :viewed
    end
  end
end
