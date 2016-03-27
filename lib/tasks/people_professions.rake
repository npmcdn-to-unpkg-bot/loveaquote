namespace :people_professions do
	task :import => :environment do
		Person.all.each do |person|
			PersonProfession.create(person_id: person.id, profession_id: person.profession.id) if person.profession.present?
		end
	end
end