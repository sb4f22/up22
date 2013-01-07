class ApplicationController < ActionController::Base
  
protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end


def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end


  def store_location
    session[:return_to] = request.fullpath
  end
  
 def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private
    def clear_return_to
      session.delete(:return_to)
    end

end
