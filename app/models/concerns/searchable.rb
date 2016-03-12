module Searchable
    extend ActiveSupport::Concern
    
    included do
        has_many :user_searches, as: :source, dependent: :destroy
    end
end