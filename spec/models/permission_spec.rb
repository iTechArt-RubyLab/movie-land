# == Schema Information
#
# Table name: permissions
#
#  id                  :bigint           not null, primary key
#  can_edit_entities   :boolean
#  can_edit_movie      :boolean
#  can_edit_permission :boolean
#  can_edit_person     :boolean
#  can_edit_role       :boolean
#  can_give_rating     :boolean
#  can_lock_user       :boolean
#  can_read_entities   :boolean
#  can_read_movie      :boolean
#  can_read_person     :boolean
#  can_read_rating     :boolean
#  can_read_user       :boolean
#  can_set_role        :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  role_id             :bigint           not null
#
# Indexes
#
#  index_permissions_on_role_id  (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
require 'rails_helper'

RSpec.describe Permission, type: :model do
  context 'with valid attributes' do
    subject(:permission) { create :permission }

    include_examples 'valid model'
  end

  context 'with different roles' do
    context 'with admin role' do
      subject(:admin) { build :permission, :admin }

      let(:admin_role) { Role.find_by(name: 'admin') }

      it { expect(admin.role).to eq(admin_role) }
    end

    context 'with redactor role' do
      subject(:redactor) { build :permission, :redactor }

      let(:redactor_role) { Role.find_by(name: 'redactor') }

      it { expect(redactor.role).to eq(redactor_role) }
    end

    context 'with reviewer role' do
      subject(:reviewer) { build :permission, :reviewer }

      let(:reviewer_role) { Role.find_by(name: 'reviewer') }

      it { expect(reviewer.role).to eq(reviewer_role) }
    end
  end
end