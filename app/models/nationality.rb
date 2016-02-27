class Nationality < ActiveRecord::Base
    has_many :people
    validates :name, presence: true, uniqueness: true, blank: false
end
