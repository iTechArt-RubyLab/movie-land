# == Schema Information
#
# Table name: ratings
#
#  id         :bigint           not null, primary key
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_ratings_on_movie_id              (movie_id)
#  index_ratings_on_user_id               (user_id)
#  index_ratings_on_user_id_and_movie_id  (user_id,movie_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Rating, type: :model do
  context 'with valid attributes' do
    subject(:rating) { create :rating }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when rating too small' do
      subject(:invalid_small_rating) { build :rating, :invalid_small_rating }

      include_examples 'invalid model'
    end

    context 'when rating too big' do
      subject(:invalid_big_rating) { build :rating, :invalid_big_rating }

      include_examples 'invalid model'
    end
  end

  context 'with associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:movie) }
  end
end
