class SettingController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :toggle_netuse

  def toggle_netuse
    unless current_user.password_digest.nil?
      setting = Setting.first
      setting.net_allowed = !setting.net_allowed
      setting.save!

      if setting.net_allowed
        @newclasses = 'fa fa-unlock fa-2x text-success'
      else
        @newclasses = 'fa fa-lock fa-2x text-danger'
      end
      respond_to do |format|
        format.js  # toggle_netuse.js.erb
      end
    end
  end
end
