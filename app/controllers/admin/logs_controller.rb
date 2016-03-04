class Admin::LogsController < ApplicationController
  before_filter :authenticate_admin!
  layout "admin"
  
  def index
    if params[:category].present?
      @logs = Log.where(category: params[:category]).order(created_at: :DESC).page params[:page]
    else
      @logs = Log.all.order(created_at: :DESC).page params[:page]
    end
  end
end
