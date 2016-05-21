class UserMailer < ApplicationMailer
    def welcome_email(id)
        @user = User.find(id)
        mail(to: @user.email, subject: 'Welcome to LoveAQuote')
    end
end
