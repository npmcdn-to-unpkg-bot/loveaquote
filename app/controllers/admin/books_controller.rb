class Admin::BooksController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_book, only: [:show, :edit, :update, :destroy, :review]
  layout "admin"

  # GET /books
  # GET /books.json
  def index
    if params[:search].present?
      @books = Book.search_by_name(params[:search]).order(name: :ASC).page params[:page]
    elsif params[:status].present?
      case params[:status]
      when "Draft"
        @books = Book.draft.search_by_name(params[:search]).order(name: :ASC).page params[:page]
      when "Published"
        @books = Book.published.search_by_name(params[:search]).order(name: :ASC).page params[:page]
      end
    elsif params[:person].present?
      @books = Book.joins(:compositions).where(compositions: { person_id: params[:person] }).order(name: :ASC).page params[:page]
    else
      @books = Book.order(name: :ASC).page params[:page]
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
    @book.build_seo
  end

  # GET /books/1/edit
  def edit
    @book.build_seo if @book.seo.nil?
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to admin_book_url(@book), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to admin_book_url(@book), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def review
    @review = @book.review || @book.build_review
    @review.date = Date.today
    @review.save
    redirect_to admin_book_path(@book)
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to admin_books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :isbn, :fetch_url, :published, :popular, :very_popular, :source_id, :source_type, :person_id, :image, character_sources_attributes: [:id, :character_id, :person_id, :_destroy], seo_attributes: [:id, :title, :description, :_destroy], compositions_attributes: [:id, :person_id, :_destroy])
    end
end
