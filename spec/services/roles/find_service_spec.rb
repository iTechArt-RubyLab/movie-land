require 'rails_helper'

RSpec.describe Roles::FindService, type: :model do
  subject(:role_service) { described_class }

  let!(:roles) { create_list(:role, 5) }

  describe '#call' do
    context 'when params contain name one of role' do
      let!(:role) { roles.first }
      let(:params) { { filter: role.name } }

      it { expect(role_service.call(params)).eql? role }
    end

    context 'when params contain name of non-existent role' do
      let(:params) { { filter: Faker::Lorem.characters(number: 7) } }

      it { expect(role_service.call(params).count).to eq 0 }
    end

    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it { expect(role_service.call(params)).eql? roles.sort_by(&:name).reverse }
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it { expect(role_service.call(params)).eql? roles.sort_by(&:name) }
    end
  end
end
