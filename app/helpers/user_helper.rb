module UserHelper
  def seconds_to_minutes(seconds)
    "#{(seconds / 60).round.to_s} min"
  end

  def remaining_quota(usage_seconds)
    (3600 - usage_seconds).round
  end

  def remaining_percentage(usage_seconds)
    (1 - (usage_seconds/3600))*100
  end
  
  def progress_bar_class(remaining_percentage)
    if remaining_percentage <= 20
      'progress-bar-danger'
    elsif remaining_percentage <= 70
      'progress-bar-warning'
    else
      'progress-bar-success'
    end
  end
end
