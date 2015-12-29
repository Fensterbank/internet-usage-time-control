class User < ActiveRecord::Base
  has_secure_password

  def today_used_time
    pings = Ping.where('user_id = ? and created_at >= ?', self.id, Time.zone.now.beginning_of_day).order('created_at asc')
    usage = 0.0
    pings.each_with_index do | ping, index |
      if index > 0
        diff = ping.created_at - pings[index-1].created_at

        # Check if threshold reached
        if diff < 35.0
          usage += diff
        end
      end
    end
    usage
  end

  def reset_today
    Ping.where('user_id = ? and created_at >= ?', self.id, Time.zone.now.beginning_of_day).delete_all
  end
end
