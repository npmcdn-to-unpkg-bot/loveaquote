class TimeLine < ActiveRecord::Base
    belongs_to :item, polymorphic: true
    validates_uniqueness_of :item_id, scope: :item_type

    after_commit :expire_cache

    def expire_cache
        Rails.cache.delete("time-line-cached-count")
    end

    def self.recent
        all.order(created_at: :desc).limit(10)
    end

    def self.cached_count
        Rails.cache.fetch("time-line-cached-count") do
            count
        end
    end
end
