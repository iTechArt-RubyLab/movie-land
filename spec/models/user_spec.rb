# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  birthday               :date
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  name                   :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  surname                :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with valid attributes' do
    subject(:user) { create :user }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too short' do
      subject(:invalid_short_name) { build :user, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'when name too long' do
      subject(:invalid_long_name) { build :user, :invalid_long_name }

      include_examples 'invalid model'
    end

    context 'when surname too short' do
      subject(:invalid_short_surname) { build :user, :invalid_short_surname }

      include_examples 'invalid model'
    end

    context 'when surname too long' do
      subject(:invalid_long_surname) { build :user, :invalid_long_surname }

      include_examples 'invalid model'
    end

    context 'when username too short' do
      subject(:invalid_short_username) { build :user, :invalid_short_username }

      include_examples 'invalid model'
    end

    context 'when username too long' do
      subject(:invalid_long_username) { build :user, :invalid_long_username }

      include_examples 'invalid model'
    end
  end

  context 'with associations' do
    it { is_expected.to belong_to(:role).optional }
    it { is_expected.to have_many(:ratings) }
    it { is_expected.to delegate_method(:can_read_entities?).to(:role) }
    it { is_expected.to delegate_method(:can_edit_entities?).to(:role) }
    it { is_expected.to delegate_method(:can_lock_user?).to(:role) }
    it { is_expected.to delegate_method(:can_read_rating?).to(:role) }
    it { is_expected.to delegate_method(:can_give_rating?).to(:role) }
    it { is_expected.to delegate_method(:can_export_to_csv?).to(:role) }
    it { is_expected.to delegate_method(:can_read_user?).to(:role) }
    it { is_expected.to delegate_method(:can_edit_role?).to(:role) }
    it { is_expected.to delegate_method(:can_edit_permission?).to(:role) }
    it { is_expected.to delegate_method(:can_set_role?).to(:role) }
    it { is_expected.to delegate_method(:can_edit_person?).to(:role) }
    it { is_expected.to delegate_method(:can_read_movie?).to(:role) }
    it { is_expected.to delegate_method(:can_edit_movie?).to(:role) }
    it { is_expected.to delegate_method(:can_read_person?).to(:role) }
    it { is_expected.to delegate_method(:can_read_award?).to(:role) }
    it { is_expected.to delegate_method(:can_edit_award?).to(:role) }
    it { is_expected.to delegate_method(:can_read_view_list?).to(:role) }
    it { is_expected.to delegate_method(:can_edit_view_list?).to(:role) }
    it { is_expected.to delegate_method(:admin?).to(:role) }
    it { is_expected.to delegate_method(:redactor?).to(:role) }
    it { is_expected.to delegate_method(:reviewer?).to(:role) }
  end
end
