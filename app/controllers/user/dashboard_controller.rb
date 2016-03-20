class User::DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "user"
end
