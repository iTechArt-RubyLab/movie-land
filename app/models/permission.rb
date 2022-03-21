# == Schema Information
#
# Table name: permissions
#
#  id                  :bigint           not null, primary key
#  can_edit_award      :boolean
#  can_edit_entities   :boolean
#  can_edit_movie      :boolean
#  can_edit_permission :boolean
#  can_edit_person     :boolean
#  can_edit_role       :boolean
#  can_edit_view_list  :boolean
#  can_export_to_csv   :boolean
#  can_give_rating     :boolean
#  can_leave_comment   :boolean
#  can_lock_user       :boolean
#  can_read_award      :boolean
#  can_read_entities   :boolean
#  can_read_movie      :boolean
#  can_read_person     :boolean
#  can_read_rating     :boolean
#  can_read_user       :boolean
#  can_read_view_list  :boolean
#  can_set_role        :boolean
#  can_use_search      :boolean
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
class Permission < ApplicationRecord
  belongs_to :role
end
