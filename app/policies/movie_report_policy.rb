class MovieReportPolicy < ApplicationPolicy
  def index?
    user.can_export_to_csv?
  end

  def show?
    user.can_export_to_csv?
  end
end
