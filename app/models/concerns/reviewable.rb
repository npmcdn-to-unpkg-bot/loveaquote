module Reviewable
    extend ActiveSupport::Concern

    included do
        has_one :review, as: :source, dependent: :destroy
    end
end