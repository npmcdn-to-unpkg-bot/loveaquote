module SearchSuggestable
    extend ActiveSupport::Concern
    
    included do
        has_many :search_suggestions, as: :source, dependent: :destroy
    end
end