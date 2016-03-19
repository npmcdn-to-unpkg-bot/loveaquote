FactoryGirl.define do
	factory :book do
		name { Faker::Name.name }
	end
end