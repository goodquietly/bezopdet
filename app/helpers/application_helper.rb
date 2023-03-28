module ApplicationHelper
  def child_protection(programs)
    programs.where(completed: true).size * 100 / programs.size
  end

  def random_bootstrap_colors
    %w[primary success danger warning info].sample
  end

  def left_square_icon
    content_tag 'i', '', class: 'text-warning bi bi-arrow-left-square-fill'
  end

  def right_square_icon
    content_tag 'i', '', class: 'text-warning bi bi-arrow-right-square-fill'
  end
end
