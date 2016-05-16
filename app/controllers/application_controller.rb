class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
    def after_sign_in_path_for(resource)
        if resource.is_a?(User)
            request.env['omniauth.origin']
        else
            super
        end
    end
    
    def after_sign_out_path_for(resource)
        if resource.is_a?(User)
            request.fullpath || root_path
        else
            super
        end
    end
end