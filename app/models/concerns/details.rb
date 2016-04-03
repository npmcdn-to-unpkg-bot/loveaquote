module Details
	def byline
		case self.class.name
		when "Person"
			person_byline
		end
	end

	def person_byline
		byline = []
		byline << self.nationality.name if self.nationality.present?
		byline << self.professions.pluck(:name).to_sentence.downcase if self.professions.any?
		byline << self.born_and_died if self.born_and_died.present?
		byline.join(", ")
	end

	def born_and_died
		if self.born.present?
			born = self.born.present? ? self.born.strftime("%Y").to_s : ""
			died = self.died.present? ? self.died.strftime("%Y").to_s : ""
			born + "-" + died
		end
	end
end