class Profession < ActiveRecord::Base
    has_many :person_professions, dependent: :destroy
    validates :name, presence: true, uniqueness: true, blank: false
end
