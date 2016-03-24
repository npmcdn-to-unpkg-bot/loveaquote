module FeaturedTopicable
	extend ActiveSupport::Concern

    included do
        has_many :featured_topics, as: :source, dependent: :destroy
        accepts_nested_attributes_for :featured_topics, reject_if: :all_blank
    end
end