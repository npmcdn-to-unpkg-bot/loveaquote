module Quotable
    extend ActiveSupport::Concern
    
    included do
        has_many :quotes, as: :source, dependent: :destroy
    end
end