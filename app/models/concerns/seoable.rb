module Seoable
    extend ActiveSupport::Concern

    included do
        has_one :seo, as: :source, dependent: :destroy
        accepts_nested_attributes_for :seo, reject_if: :all_blank
    end

    def title
        if self.seo_title
            #do something
        else
            generate_title
        end
    end

    def description
        if self.seo_description
            #do something
        else
            generate_description
        end
    end

    def seo_title
        if self.seo && self.seo.title
            self.seo.title
        else
            nil
        end
    end

    def seo_description
        if self.seo && self.seo.description
            self.seo.description
        else
            nil
        end
    end

    def generate_title
        case self.class.name
        when "Topic"
            "#{self.name} Quotes - #{self.quotes.count} Best Quotes about #{self.name}"
        end
    end

    def generate_description
        case self.class.name
        when "Topic"
            "Quotes about #{self.name}. Best collection of #{self.name} quotes brought to you by LoveAQuote. Enjoy reading these quotes on #{self.name}."
        end
    end
end