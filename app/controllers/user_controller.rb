class UserController < ApplicationController

  def index
    if params['logontoken'] == 'nJdf83JKXCmda347' && params['user']
      unless Setting.first.net_allowed
        render :text => 0
        return
      end
      user = User.find_by_name(params['user'])
      if user.nil?
        user = User.new
        user.name = params['user']
        user.net_allowed = true
        user.save!(validate:false)
      end

      unless user.net_allowed
        render :text => 0
        return
      end

      ping = Ping.new
      ping.user_id = user.id
      ping.save!

      render :text => (3600 - user.today_used_time).round
    else
      require_login

      logger.debug('Reunder users')

      @users = User.all.order('name asc')
      logger.debug(@users.inspect)
    end
  end

  def reset
    unless current_user.password_digest.nil?
      @user = User.find(params['id'])
      @user.reset_today

      respond_to do |format|
        format.js  # toggle_netuse.js.erb
      end
    end
  end

  def delete
    unless current_user.password_digest.nil?
      user = User.find(params['id'])
      user.delete

      @userid = params['id']
      respond_to do |format|
        format.js  # toggle_netuse.js.erb
      end
    end
  end

  def toggle_netuse
    unless current_user.password_digest.nil?
      user = User.find(params['id'])
      user.net_allowed = !user.net_allowed
      user.save!(validate:false)

      @userid = params['id']
      if user.net_allowed
        @newclasses = 'fa fa-fw fa-unlock text-success'
      else
        @newclasses = 'fa fa-fw fa-lock text-danger'
      end

      respond_to do |format|
        format.js  # toggle_netuse.js.erb
      end
    end
  end
end
