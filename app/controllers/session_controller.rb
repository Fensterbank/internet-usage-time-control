class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if !user.nil?
      if user.password_digest.nil?
        flash.now.alert = 'Benutzer ist nicht zum Login berechtigt!'
        render 'new'
      else
        if user.authenticate(params[:password])
          logger.debug('Erfolgreich')
          session[:user_id] = user.id
          redirect_to root_path
        else
          flash.now.alert = 'Fehlerhafte E-Mail-Adresse oder Passwort'
          render 'new'
        end
      end
    else
      flash.now.alert = 'Fehlerhafte E-Mail-Adresse oder Passwort'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session['slideshow_downloads'] = nil
    session['slideshow_generals'] = nil
    redirect_to index_path
  end
end
