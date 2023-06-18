class ContactPolicy < ApplicationPolicy
  def create?
    user == record.child.user
  end

  def destroy?
    user == record.child.user
  end
end
