require 'rails_helper'

RSpec.describe Dictionary::FindService, type: :model do
  subject(:find_service) { described_class.new(class_name, params) }

  before do
    Faker::Book.unique.clear
    Faker::UniqueGenerator.clear
  end

  let!(:genres) { create_list(:genre, 20) }
  let(:class_name) { Genre }

  describe '#call' do
    context 'when params contain full name one of genres' do
      let!(:genre) { genres.first }
      let(:params) { { filter: genre.name } }

      it 'returns genre' do
        expect(find_service.call).eql? genre
      end
    end

    context 'when params contain name of non-existent genres' do
      let(:params) { { filter: Faker::Lorem.characters(number: 7) } }

      it 'returns count of genres' do
        expect(find_service.call.count).to eq 0
      end
    end

    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it 'returns genres' do
        expect(find_service.call).eql? genres.sort_by(&:name).reverse
      end
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it 'returns genres' do
        expect(find_service.call).eql? genres.sort_by(&:name)
      end
    end
  end
end
