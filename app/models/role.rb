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
  validates :name, uniqueness: { message: 'This role already exists' }
  accepts_nested_attributes_for :permission

  def can_lock_user?
    admin? ? true : permision? && permission.can_lock_user
  end

  def can_read_user?
    predefined_user? ? true : permision? && permission.can_lock_user
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
    [admin?, redactor?, reviewer?].include?(name)
  end

  def editor?
    [admin?, redactor?].include?(name)
  end

  private

  def permision?
    !permission.nil?
  end
end
