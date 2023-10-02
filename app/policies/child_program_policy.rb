# frozen_string_literal: true

class ChildProgramPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    user == record.child.user
  end

  def show?
    user == record.child.user
  end

  def complete?
    user == record.child.user && !record.completed?
  end

  class Scope
    def initialize(user_context, scope)
      @id = user_context.child_id
      @scope = scope
    end

    def resolve
      scope.where(child_id: id)
    end

    private

    attr_reader :scope, :id
  end
end
