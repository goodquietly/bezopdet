module ApplicationHelper
  def child_protection(programs)
    programs.where(completed: true).size * 100 / programs.size
  end
end
