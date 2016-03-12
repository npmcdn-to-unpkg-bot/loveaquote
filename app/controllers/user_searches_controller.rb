class UserSearchesController < ApplicationController
  before_action :set_user_search, only: [:show, :edit, :update, :destroy]

  # GET /user_searches
  # GET /user_searches.json
  def index
    @user_searches = UserSearch.all
  end

  # GET /user_searches/1
  # GET /user_searches/1.json
  def show
  end

  # GET /user_searches/new
  def new
    @user_search = UserSearch.new
  end

  # GET /user_searches/1/edit
  def edit
  end

  # POST /user_searches
  # POST /user_searches.json
  def create
    @user_search = UserSearch.new(user_search_params)

    respond_to do |format|
      if @user_search.save
        format.html { redirect_to @user_search, notice: 'User search was successfully created.' }
        format.json { render :show, status: :created, location: @user_search }
      else
        format.html { render :new }
        format.json { render json: @user_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_searches/1
  # PATCH/PUT /user_searches/1.json
  def update
    respond_to do |format|
      if @user_search.update(user_search_params)
        format.html { redirect_to @user_search, notice: 'User search was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_search }
      else
        format.html { render :edit }
        format.json { render json: @user_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_searches/1
  # DELETE /user_searches/1.json
  def destroy
    @user_search.destroy
    respond_to do |format|
      format.html { redirect_to user_searches_url, notice: 'User search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_search
      @user_search = UserSearch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_search_params
      params.require(:user_search).permit(:text, :source_id)
    end
end
