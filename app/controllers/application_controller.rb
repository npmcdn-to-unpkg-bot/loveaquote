class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
  
      def after_sign_in_path_for(resource)
          if resource.is_a?(User)
              my_root_url
          else
              super
          end
      end
  
    def after_sign_out_path_for(resource_or_scope)
        if resource_or_scope.to_s == "user"
            new_user_session_url
        else
            super
        end
    end
  
end