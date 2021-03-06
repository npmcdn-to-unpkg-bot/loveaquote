class Admin::RedirectsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_redirect, only: [:edit, :update, :destroy]

  # GET /redirects
  # GET /redirects.json
  def index
    @redirects = Redirect.all
  end

  # GET /redirects/new
  def new
    @redirect = Redirect.new
  end

  # GET /redirects/1/edit
  def edit
  end

  # POST /redirects
  # POST /redirects.json
  def create
    @redirect = Redirect.new(redirect_params)

    respond_to do |format|
      if @redirect.save
        format.html { redirect_to admin_redirects_path, notice: 'Redirect was successfully created.' }
        format.json { render :show, status: :created, location: @redirect }
      else
        format.html { render :new }
        format.json { render json: @redirect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /redirects/1
  # PATCH/PUT /redirects/1.json
  def update
    respond_to do |format|
      if @redirect.update(redirect_params)
        format.html { redirect_to admin_redirects_path, notice: 'Redirect was successfully updated.' }
        format.json { render :show, status: :ok, location: @redirect }
      else
        format.html { render :edit }
        format.json { render json: @redirect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redirects/1
  # DELETE /redirects/1.json
  def destroy
    @redirect.destroy
    respond_to do |format|
      format.html { redirect_to admin_redirects_path, notice: 'Redirect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redirect
      @redirect = Redirect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def redirect_params
      params.require(:redirect).permit(:source_id, :from, :to)
    end
end
