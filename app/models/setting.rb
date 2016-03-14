class Setting < ActiveRecord::Base
    
    after_save :expire_cache
    
    def expire_cache
       Rails.cache.delete("site_settings_verification_tags")
       Rails.cache.delete("site_settings_analytics") 
    end
    
    def self.google_verification
        if self.first
            self.first.google_verification
        else
            ""
        end
    end
    
    def self.bing_verification
        if self.first
            self.first.bing_verification
        else
            ""
        end
    end
    
    def self.yandex_verification
        if self.first
            self.first.yandex_verification
        else
            ""
        end
    end
    
    def self.alexa_verification
        if self.first
            self.first.alexa_verification
        else
            ""
        end
    end
    
    def self.google_analytics
        if self.first
            self.first.google_analytics
        else
            ""
        end
    end
    
    def self.facebook_url
        if self.first
            self.first.facebook_url
        else
            ""
        end
    end    
    
    def self.pinterest_url
        if self.first
            self.first.pinterest_url
        else
            ""
        end
    end
    
    def self.google_plus_url
        if self.first
            self.first.google_plus_url
        else
            ""
        end
    end    
    
    def self.twitter_url
        if self.first
            self.first.twitter_url
        else
            ""
        end
    end        
end
