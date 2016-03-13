class TimeLine < ActiveRecord::Base
    belongs_to :item, polymorphic: true
    validates_uniqueness_of :item_id, scope: :item_type
    
    after_create :expire_cache
    
    def expire_cache
        Rails.cache.delete("footer_widgets")
    end
end
