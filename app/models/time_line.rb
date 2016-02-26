class TimeLine < ActiveRecord::Base
    belongs_to :item, polymorphic: true
    validates_uniqueness_of :item_id, scope: :item_type
end
