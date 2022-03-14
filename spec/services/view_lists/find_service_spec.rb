require 'rails_helper'

<<<<<<< HEAD:spec/services/view_lists/find_service_spec.rb
RSpec.describe ViewLists::FindService, type: :model do
  subject(:view_list_service) { described_class }
=======
RSpec.describe EntityManager::ViewListService, type: :model do
  subject(:view_list_service) { described_class.new(user: user, attributes: params) }
>>>>>>> 4d48945 (ML-049/move services):spec/services/entity_manager/view_list_service_spec.rb

  let!(:view_lists) { create_list(:view_list, 10) }
  let(:user) { create :user, :reviewer }

  describe '#call' do
    context 'when params contain order by desc' do
      let(:params) { { order: :desc } }

<<<<<<< HEAD:spec/services/view_lists/find_service_spec.rb
      it do
        expect(view_list_service.call(user, params)).eql? view_lists.sort_by(&:watching_status).reverse
=======
      it 'returns view lists' do
        expect(view_list_service.call).eql? view_lists.sort_by(&:watching_status).reverse
>>>>>>> 4d48945 (ML-049/move services):spec/services/entity_manager/view_list_service_spec.rb
      end
    end

    context 'when params is empty and default order by asc' do
      let(:params) { {} }

<<<<<<< HEAD:spec/services/view_lists/find_service_spec.rb
      it do
        expect(view_list_service.call(user, params)).eql? view_lists.sort_by(&:watching_status)
=======
      it 'returns view lists' do
        expect(view_list_service.call).eql? view_lists.sort_by(&:watching_status)
>>>>>>> 4d48945 (ML-049/move services):spec/services/entity_manager/view_list_service_spec.rb
      end
    end
  end
end
