# frozen_string_literal: true

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
class User < ApplicationRecord
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  belongs_to :role, optional: true
  has_many :ratings, dependent: :destroy
  has_many :view_lists, dependent: :destroy

  delegate :can_read_entities?, :can_edit_entities?, :can_lock_user?, :can_read_rating?, :can_give_rating?,
           :can_read_user?, :can_edit_role?, :can_edit_permission?, :can_set_role?, :can_edit_person?,
           :can_read_movie?, :can_edit_movie?, :can_read_person?, :admin?, :redactor?, :reviewer?,
           :can_read_award?, :can_edit_award?, :can_read_view_list?, :can_edit_view_list?,
           :can_leave_comment?, :can_export_to_csv?, :can_use_search?, to: :role

  validates :name, length: { in: 2..25 }
  validates :surname, length: { in: 2..25 }
  validates :username, length: { in: 4..20 }, uniqueness: { message: 'User with this username already exists' }
  validates :birthday, presence: true

  before_save :default_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable, :trackable

  private

  def default_role
    self.role ||= Role.find_or_create_by(name: 'reviewer')
  end
end
