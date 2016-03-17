class TimeLine < ActiveRecord::Base
    belongs_to :item, polymorphic: true
    validates_uniqueness_of :item_id, scope: :item_type
    
    after_commit :expire_cache
    
    def expire_cache
        Rails.cache.delete("time-line-recent")
        Rails.cache.delete("footer_widgets")
    end
    
    def self.recent
        all.order(created_at: :desc).limit(10)
    end
    
    def self.cached_recent
       Rails.cache.fetch("time-line-recent") do
           recent
       end
    end
end
