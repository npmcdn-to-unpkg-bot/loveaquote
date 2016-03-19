require "rails_helper"

describe Person do
	it "is valid with a name" do
		expect(build(:person)).to be_valid
	end
	it "is invalid without a name" do
		expect(build(:person, name: nil)).to_not be_valid
	end
	it "is invalid with a duplicate name" do
		create(:person, name: "John Doe")
		expect(build(:person, name: "John Doe")).to_not be_valid
	end
end