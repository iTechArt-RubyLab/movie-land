require 'rails_helper'

RSpec.describe People::FindService, type: :model do
  subject(:person_service) { described_class }

  let!(:people) { create_list(:person, 3) }

  describe '#call' do
    context 'when params contain name one of people' do
      let!(:person) { people.first }
      let(:params) { { filter: person.name } }

      it { expect(person_service.call(params)).eql? person }
    end

    context 'when params contain surname one of people' do
      let!(:person) { people.second }
      let(:params) { { filter: person.surname } }

      it { expect(person_service.call(params)).eql? person }
    end

    context 'when params contain name of non-existent person' do
      let(:params) { { filter: Faker::Lorem.characters(number: 10) } }

      it { expect(person_service.call(params).count).to eq 0 }
    end

    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it { expect(person_service.call(params)).eql? people.sort_by(&:name).reverse }
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it { expect(person_service.call(params)).eql? people.sort_by(&:name) }
    end
  end
end
