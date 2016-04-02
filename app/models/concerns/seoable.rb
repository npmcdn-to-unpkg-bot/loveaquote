module Seoable
    extend ActiveSupport::Concern

    included do
        has_one :seo, as: :source, dependent: :destroy
        accepts_nested_attributes_for :seo, reject_if: :all_blank
        before_update :add_redirect
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
    
    def add_redirect
        case self.class.name
        when "Topic"
            Redirect.create(from: "/topics/#{self.slug_was}", to: "/topics/#{self.slug}.html") if self.slug_changed?
        when "Person"
            Redirect.create(from: "/people/#{self.slug_was}", to: "/people/#{self.slug}.html") if self.slug_changed?
        when "Book"
            Redirect.create(from: "/books/#{self.slug_was}", to: "/books/#{self.slug}.html") if self.slug_changed?
        when "Movie"
            Redirect.create(from: "/movies/#{self.slug_was}", to: "/movies/#{self.slug}.html") if self.slug_changed?
        when "TvShow"
            Redirect.create(from: "/tv-shows/#{self.slug_was}", to: "/tv-shows/#{self.slug}.html") if self.slug_changed?
        when "Character"
            Redirect.create(from: "/characters/#{self.slug_was}", to: "/characters/#{self.slug}.html") if self.slug_changed?            
        end
    end
end