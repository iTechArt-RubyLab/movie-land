require 'rails_helper'

RSpec.describe Awards::FindService, type: :model do
  subject(:award_service) { described_class }

  let!(:awards) { create_list(:award, 20) }

  describe '#call' do
    context 'when params contain name one of awards' do
      let!(:award) { awards.first }
      let(:params) { { filter: award.name } }

      it { expect(award_service.call(params)).eql? award }
    end

    context 'when params contain name of non-existent award' do
      let(:params) { { filter: Faker::Lorem.characters(number: 7) } }

      it { expect(award_service.call(params).count).to eq 0 }
    end

    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it { expect(award_service.call(params)).eql? awards.sort_by(&:name).reverse }
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it { expect(award_service.call(params)).eql? awards.sort_by(&:name) }
    end
  end
end
