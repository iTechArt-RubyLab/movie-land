require 'rails_helper'

RSpec.describe EntityManager::RatingService, type: :model do
  subject(:rating_service) { described_class }

  let!(:ratings) { create_list(:rating, 20) }
  let(:user) { create :user, :reviewer }

  describe '#call' do
    context 'when attributes contain order by desc' do
      let(:params) { { order: :desc } }

      it 'returns ratings' do
        expect(rating_service.call(user: user, attributes: params)).eql? ratings.sort_by(&:rating).reverse
      end
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it 'returns ratings' do
        expect(rating_service.call(user: user, attributes: params)).eql? ratings.sort_by(&:rating)
      end
    end
  end
end