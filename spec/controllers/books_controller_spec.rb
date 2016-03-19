require "rails_helper"

describe BooksController do
	describe "GET #index" do
		it "renders the index template" do
			get :index
			expect(response).to render_template :index
		end
	end

	describe "GET #alphabet" do
		it "renders the alphabet template" do
			get :alphabet, alphabet: "A"
			expect(response).to render_template :alphabet
		end
	end
end