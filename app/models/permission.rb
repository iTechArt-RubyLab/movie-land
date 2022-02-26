# == Schema Information
#
# Table name: permissions
#
#  id                        :bigint           not null, primary key
#  can_edit_entities         :boolean
#  can_edit_movie_and_person :boolean
#  can_edit_role             :boolean
#  can_lock_user             :boolean
#  can_read_entities         :boolean
#  can_read_movie_and_person :boolean
#  can_set_role              :boolean
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  role_id                   :bigint           not null
#
# Indexes
#
#  index_permissions_on_role_id  (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class Permission < ApplicationRecord
  belongs_to :role
end
