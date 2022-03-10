require 'rails_helper'

RSpec.describe PersonService, type: :model do
  subject(:person_service) { described_class.new(class_name, params) }

  let!(:people) { create_list(:person, 20) }
  let(:class_name) { Person }

  describe '#call' do
    context 'when params contain name one of people' do
      let!(:person) { people.first }
      let(:params) { { filter: person.name } }

      it 'returns person' do
        expect(person_service.call).eql? person
      end
    end

    context 'when params contain surname one of people' do
      let!(:person) { people.second }
      let(:params) { { filter: person.surname } }

      it 'returns person' do
        expect(person_service.call).eql? person
      end
    end

    context 'when params contain name of non-existent person' do
      let(:params) { { filter: Faker::Lorem.characters(number: 7) } }

      it 'returns count of people' do
        expect(person_service.call.count).to eq 0
      end
    end

    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it 'returns people' do
        expect(person_service.call).eql? people.sort_by(&:name).reverse
      end
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it 'returns people' do
        expect(person_service.call).eql? people.sort_by(&:name)
      end
    end
  end
end
