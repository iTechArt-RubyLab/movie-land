class PersonReportPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_export_to_csv?
  end

  def show?
    user.can_export_to_csv?
  end
end
