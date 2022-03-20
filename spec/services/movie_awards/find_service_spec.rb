require 'rails_helper'

RSpec.describe MovieAwards::FindService, type: :model do
  subject(:category_service) { described_class }

  let!(:movie_awards) { create_list(:movie_award, 20) }

  describe '#call' do
    context 'when params contain movie with id 1' do
      let(:params) { { movie_id: 1 } }

      it { expect(category_service.call(params)).eql?(movie_awards.delete_if { |movie_award| movie_award[4] != 1 }) }
    end

    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it { expect(category_service.call(params)).eql? movie_awards.sort_by(&:delivery_year).reverse }
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it { expect(category_service.call(params)).eql? movie_awards.sort_by(&:delivery_year) }
    end
  end
end
