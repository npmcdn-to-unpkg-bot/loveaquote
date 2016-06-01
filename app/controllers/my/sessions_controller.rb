class My::SessionsController < Devise::SessionsController
    layout "account"
    def new
        super
    end
    
    def destroy
        super
    end
end