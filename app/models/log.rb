class Log < ActiveRecord::Base
    include PgSearch
    pg_search_scope :search_by_description, against: :description, using: { tsearch: {prefix: true} }    
    
    belongs_to :source, polymorphic: true
end
