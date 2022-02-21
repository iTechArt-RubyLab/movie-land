class Role < ApplicationRecord
  has_one :permission, dependent: :destroy
  has_many :users, dependent: :nullify
  validates :name, uniqueness: { message: 'This role already exists' }
  accepts_nested_attributes_for :permission, reject_if: proc { |attributes| attributes.blank? }

  def can_read?
    predefined_user? ? true : permission.can_read
  end

  def can_lock_user?
    admin? ? true : permission.can_lock_user
  end

  def can_edit_role?
    admin? ? true : permission.can_edit_role
  end

  def can_set_role?
    admin? ? true : permission.can_set_role
  end

  def can_edit?
    editor? ? true : permission.can_set_role
  end

  private

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
end
