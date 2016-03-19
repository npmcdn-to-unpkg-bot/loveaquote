require "rails_helper"

describe BooksController do
	describe "GET #index" do
		it "renders the index template" do
			get :index
			expect(response).to render_template :index
		end
	end

	describe "GET #show" do
		it "renders the show template for a published book" do
			book = create(:book, published: true)
			get :show, id: book
			expect(response).to render_template :show
		end

		it "redirects to 404 for an unpublished book" do
			book = create(:book)
			get :show, id: book
			expect(response).to_not render_template :show
		end
	end

	describe "GET #alphabet" do
		it "renders the alphabet template" do
			get :alphabet, alphabet: "A"
			expect(response).to render_template :alphabet
		end
	end
end