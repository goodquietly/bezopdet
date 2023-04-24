module ApplicationHelper
  def child_protection(programs)
    return programs.where(completed: true).size.* 100 / programs.size if programs.present?

    0
  end

  def protection_color(programs)
    if child_protection(programs) < 30
      '#ff4d4d'
    elsif child_protection(programs) >= 70
      '#41ff30'
    else
      '#eaff30'
    end
  end

  def protection_raiting(programs)
    if child_protection(programs) < 30
      'НИЗКИЙ'
    elsif child_protection(programs) >= 70
      'ВЫСОКИЙ'
    else
      'СРЕДНИЙ'
    end
  end

  def random_bootstrap_colors
    %w[primary success danger warning info].sample
  end

  def left_square_icon
    content_tag 'i', '', class: 'text-warning bi bi-arrow-left-square-fill fs-4'
  end

  def right_square_icon
    content_tag 'i', '', class: 'text-warning bi bi-arrow-right-square-fill fs-4'
  end
end
