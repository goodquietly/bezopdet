class ChildPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user
  end

  def index?
    true
  end

  def passport?
    record.user == user
  end

  def interactive_passport?
    record.user == user && user.personal_data_policy_confirmed?
  end

  class Scope
    def initialize(user_context, scope)
      @user = user_context.user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id) if user.present?
    end

    private

    attr_reader :scope, :user
  end
end
