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
  subject(:user) { create :user }

  context 'with valid attributes' do
    it { expect(user).to be_valid }
  end

  describe '#name' do
    context 'when name is short' do
      subject(:invalid_short_name) { build :user, :invalid_short_name }

      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name is long' do
      subject(:invalid_long_name) { build :user, :invalid_long_name }

      it { expect(invalid_long_name).not_to be_valid }
    end
  end

  describe '#surname' do
    context 'when surname is short' do
      subject(:invalid_short_surname) { build :user, :invalid_short_surname }

      it { expect(invalid_short_surname).not_to be_valid }
    end

    context 'when surname is long' do
      subject(:invalid_long_surname) { build :user, :invalid_long_surname }

      it { expect(invalid_long_surname).not_to be_valid }
    end
  end

  describe '#username' do
    context 'when username is short' do
      subject(:invalid_short_username) { build :user, :invalid_short_username }

      it { expect(invalid_short_username).not_to be_valid }
    end

    context 'when username is long' do
      subject(:invalid_long_username) { build :user, :invalid_long_username }

      it { expect(invalid_long_username).not_to be_valid }
    end
  end
end
