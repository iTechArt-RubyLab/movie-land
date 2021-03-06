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
class Role < ApplicationRecord
  has_one :permission, dependent: :destroy
  has_many :users, dependent: :nullify
  accepts_nested_attributes_for :permission

  validates :name, length: { in: 2..100 }, uniqueness: { message: 'This role already exists' }

  def can_lock_user?
    admin? ? true : permision? && permission.can_lock_user
  end

  def can_read_user?
    predefined_user? ? true : permision? && permission.can_lock_user
  end

  def can_read_rating?
    predefined_user? ? true : permision? && permission.can_read_rating
  end

  def can_give_rating?
    predefined_user? ? true : permision? && permission.can_give_rating
  end

  def can_read_view_list?
    predefined_user? ? true : permision? && permission.can_read_view_list
  end

  def can_edit_view_list?
    predefined_user? ? true : permision? && permission.can_edit_view_list
  end

  def can_leave_comment?
    predefined_user? ? true : permision? && permission.can_leave_comment
  end

  def can_export_to_csv?
    editor? ? true : permision? && permission.can_export_to_csv
  end

  def can_use_search?
    predefined_user? ? true : permision? && permission.can_use_search
  end

  def can_edit_role?
    admin? ? true : permision? && permission.can_edit_role
  end

  def can_edit_permission?
    admin? ? true : permision? && permission.can_edit_permission
  end

  def can_set_role?
    admin? ? true : permision? && permission.can_set_role
  end

  def can_read_entities?
    editor? ? true : permision? && permission.can_read_entities
  end

  def can_edit_entities?
    editor? ? true : permision? && permission.can_edit_entities
  end

  def can_read_movie?
    predefined_user? ? true : permision? && permission.can_read_movie
  end

  def can_edit_movie?
    editor? ? true : permision? && permission.can_edit_movie
  end

  def can_read_person?
    predefined_user? ? true : permision? && permission.can_read_person
  end

  def can_edit_person?
    editor? ? true : permision? && permission.can_edit_person
  end

  def can_read_award?
    predefined_user? ? true : permision? && permission.can_read_award
  end

  def can_edit_award?
    editor? ? true : permision? && permission.can_edit_award
  end

  def admin?
    name == 'admin'
  end

  def redactor?
    name == 'redactor'
  end

  def reviewer?
    name == 'reviewer'
  end

  def predefined_user?
    admin? || redactor? || reviewer?
  end

  def editor?
    admin? || redactor?
  end

  private

  def permision?
    !permission.nil?
  end
end
