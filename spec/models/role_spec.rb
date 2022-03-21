# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { create :role }

  context 'with valid attributes' do
    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too short' do
      subject(:invalid_short_name) { build :role, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'when name too long' do
      subject(:invalid_long_name) { build :role, :invalid_long_name }

      include_examples 'invalid model'
    end
  end

  context 'with permissions' do
    subject(:admin_role) { described_class.create(name: 'admin') }

    context 'when can_lock_user' do
      it { expect(admin_role).to be_can_lock_user }
    end

    context 'when can_read_user' do
      it { expect(admin_role).to be_can_read_user }
    end

    context 'when can_read_rating' do
      it { expect(admin_role).to be_can_read_rating }
    end

    context 'when can_give_rating' do
      it { expect(admin_role).to be_can_give_rating }
    end

    context 'when can_read_view_list' do
      it { expect(admin_role).to be_can_read_view_list }
    end

    context 'when can_edit_view_list' do
      it { expect(admin_role).to be_can_edit_view_list }
    end

    context 'when can_leave_comment' do
      it { expect(admin_role).to be_can_leave_comment }
    end

    context 'when can_export_to_csv' do
      it { expect(admin_role).to be_can_export_to_csv }
    end

    context 'when can_use_search' do
      it { expect(admin_role).to be_can_use_search }
    end

    context 'when can_edit_role' do
      it { expect(admin_role).to be_can_edit_role }
    end

    context 'when can_edit_permission' do
      it { expect(admin_role).to be_can_edit_permission }
    end

    context 'when can_set_role' do
      it { expect(admin_role).to be_can_set_role }
    end

    context 'when can_read_entities' do
      it { expect(admin_role).to be_can_read_entities }
    end

    context 'when can_edit_entities' do
      it { expect(admin_role).to be_can_edit_entities }
    end

    context 'when can_read_movie' do
      it { expect(admin_role).to be_can_read_movie }
    end

    context 'when can_edit_movie' do
      it { expect(admin_role).to be_can_edit_movie }
    end

    context 'when can_read_person' do
      it { expect(admin_role).to be_can_read_person }
    end

    context 'when can_edit_person' do
      it { expect(admin_role).to be_can_edit_person }
    end

    context 'when can_read_award' do
      it { expect(admin_role).to be_can_read_award }
    end

    context 'when can_edit_award' do
      it { expect(admin_role).to be_can_edit_award }
    end

    context 'when admin' do
      it { expect(admin_role).to be_admin }
    end

    context 'when redactor' do
      subject(:redactor_role) { described_class.create(name: 'redactor') }

      it { expect(redactor_role).to be_redactor }
    end

    context 'when reviewer' do
      subject(:reviewer_role) { described_class.create(name: 'reviewer') }

      it { expect(reviewer_role).to be_reviewer }
    end

    context 'when predefined_user' do
      it { expect(admin_role).to be_predefined_user }
    end

    context 'when editor' do
      it { expect(admin_role).to be_editor }
    end
  end

  context 'with validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This role already exists') }
  end

  context 'with associations' do
    it { is_expected.to have_one(:permission) }
    it { is_expected.to have_many(:users) }
    it { is_expected.to accept_nested_attributes_for(:permission) }
  end
end
