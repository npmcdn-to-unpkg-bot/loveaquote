class Admin::LogsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_log, only: [:destroy]
  layout "admin"
  
  def index
    if params[:category].present?
      @logs = Log.where(category: params[:category]).order(created_at: :DESC).page params[:page]
    else
      @logs = Log.all.order(created_at: :DESC).page params[:page]
    end
  end
  
  def destroy
    @log.destroy
    respond_to do |format|
      format.html { redirect_to admin_logs_url, notice: 'Log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
  
    def set_log
      @book = Log.find(params[:id])
    end
end
