class Setting < ActiveRecord::Base
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
end
