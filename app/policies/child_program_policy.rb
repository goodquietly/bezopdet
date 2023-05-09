class ChildProgramPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    user == record.user
  end

  def show?
    user == record.user
  end

  def complete?
    user == record.user && !record.completed?
  end
end
