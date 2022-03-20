require 'rails_helper'

RSpec.describe Categories::FindService, type: :model do
  subject(:category_service) { described_class }

  let!(:categories) { create_list(:category, 20) }

  describe '#call' do
    context 'when params contain name one of categories' do
      let!(:category) { categories.first }
      let(:params) { { filter: category.name } }

      it { expect(category_service.call(params)).eql? category }
    end

    context 'when params contain name of non-existent category' do
      let(:params) { { filter: Faker::Lorem.characters(number: 7) } }

      it { expect(category_service.call(params).count).to eq 0 }
    end

    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it { expect(category_service.call(params)).eql? categories.sort_by(&:name).reverse }
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it { expect(category_service.call(params)).eql? categories.sort_by(&:name) }
    end
  end
end
