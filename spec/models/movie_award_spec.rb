# == Schema Information
#
# Table name: movie_awards
#
#  id              :bigint           not null, primary key
#  delivery_year   :integer
#  nomination_type :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :bigint           not null
#  movie_id        :bigint           not null
#
# Indexes
#
#  index_movie_awards_on_category_id  (category_id)
#  index_movie_awards_on_movie_id     (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (movie_id => movies.id)
#
require 'rails_helper'

RSpec.describe MovieAward, type: :model do
  context 'with valid attributes' do
    subject(:movie_award) { create :movie_award }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when delivery year too big' do
      subject(:invalid_big_delivery_year) { build :movie_award, :invalid_big_delivery_year }

      include_examples 'invalid model'
    end

    context 'when delivery year too small' do
      subject(:invalid_small_delivery_year) { build :movie_award, :invalid_small_delivery_year }

      include_examples 'invalid model'
    end
  end

  context 'with associations' do
    it { should belong_to(:movie) }
    it { should belong_to(:category) }
    it { should have_many(:movie_awards_people) }
    it { should have_many(:people) }
  end
end
