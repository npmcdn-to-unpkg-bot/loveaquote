class Setting < ActiveRecord::Base
    def self.google_verification
        self.first.google_verification || ""
    end
    
    def self.bing_verification
        self.first.bing_verification || ""
    end
    
    def self.yandex_verification
        self.first.yandex_verification || ""
    end
    
    def self.alexa_verification
        self.first.alexa_verification || ""
    end
    
    def self.google_analytics
        self.first.google_analytics || ""
    end
end
