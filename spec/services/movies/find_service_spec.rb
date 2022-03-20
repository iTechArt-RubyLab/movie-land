require 'rails_helper'

RSpec.describe Movies::FindService, type: :model do
  subject(:movie_service) { described_class }

  let!(:movies) { create_list(:movie, 5) }

  describe '#call' do
    context 'when params contain name one of movies' do
      let!(:movie) { movies.first }
      let(:params) { { filter: movie.name } }

      it { expect(movie_service.call(params)).eql? movie }
    end

    context 'when params contain name of non-existent movie' do
      let(:params) { { filter: Faker::Lorem.characters(number: 7) } }

      it { expect(movie_service.call(params).count).to eq 0 }
    end

    context 'when params contain top 3 movie' do
      let(:params) { { top: 3 } }

      it { expect(movie_service.call(params)).eql? movies.sort_by { |movie| movie&.average_rating }.reverse.take(3) }
    end

    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it { expect(movie_service.call(params)).eql? movies.sort_by(&:name).reverse }
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it { expect(movie_service.call(params)).eql? movies.sort_by(&:name) }
    end
  end
end
