module Loggable
    extend ActiveSupport::Concern
    
    included do
        has_many :logs, as: :source, dependent: :destroy
    end
end