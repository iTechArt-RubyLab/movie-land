require 'rails_helper'

RSpec.describe Ratings::FindService, type: :model do
  subject(:rating_service) { described_class }

  let!(:ratings) { create_list(:rating, 20) }
  let(:user) { create :user, :reviewer }

  describe '#call' do
    context 'when attributes contain order by desc' do
      let(:params) { { order: :desc } }

      it { expect(rating_service.call(user, params)).eql? ratings.sort_by(&:rating).reverse }
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it { expect(rating_service.call(user, params)).eql? ratings.sort_by(&:rating) }
    end
  end
end
