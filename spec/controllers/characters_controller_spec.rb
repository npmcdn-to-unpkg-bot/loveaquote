require "rails_helper"

describe CharactersController do
	describe "GET #index" do
		it "renders the index template" do
			get :index
			expect(response).to render_template :index
			expect(response.status).to eq(200)
		end
	end

	describe "GET #alphabet" do
		it "renders the alphabet template" do
			get :alphabet, alphabet: "A"
			expect(response).to render_template :alphabet
		end
	end
end