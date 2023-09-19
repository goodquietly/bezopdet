class ContactPolicy < ApplicationPolicy
  def create?
    user == record.child.user && user.personal_data_policy_confirmed?
  end

  def destroy?
    user == record.child.user && user.personal_data_policy_confirmed?
  end
end
