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
#  index_ratings_on_movie_id  (movie_id)
#  index_ratings_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Rating, type: :model do
  subject(:rating) { create :rating }

  context 'with valid attributes' do
    it { expect(rating).to be_valid }
  end

  describe '#rating' do
    context 'when rating is short' do
      subject(:invalid_short_rating) { build :rating, :invalid_short_rating }

      it { expect(invalid_short_rating).not_to be_valid }
    end

    context 'when rating is long' do
      subject(:invalid_long_rating) { build :rating, :invalid_long_rating }

      it { expect(invalid_long_rating).not_to be_valid }
    end
  end

  context 'with associations' do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end
end
