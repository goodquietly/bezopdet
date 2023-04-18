class UserPolicy < ApplicationPolicy
  def show?
    record == user
  end

  def passport?
    record == user
  end
end
