require 'rails_helper'

RSpec.describe ViewLists::FindService, type: :model do
  subject(:view_list_service) { described_class }

  let!(:view_lists) { create_list(:view_list, 10) }
  let(:user) { create :user, :reviewer }

  describe '#call' do
    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

      it do
        expect(view_list_service.call(user, params)).eql? view_lists.sort_by(&:watching_status).reverse
      end
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

      it do
        expect(view_list_service.call(user, params)).eql? view_lists.sort_by(&:watching_status)
      end
    end
  end
end
