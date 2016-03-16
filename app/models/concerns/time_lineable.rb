module TimeLineable
    extend ActiveSupport::Concern
    
    included do
        has_one :time_line, as: :item, dependent: :destroy
        after_commit :add_to_time_line_on_create, on: [:create]
        after_save :add_to_time_line_on_save
    end
    
    def add_to_time_line_on_create
        TimeLine.create(item: self) if self.published
    end
    
    def add_to_time_line_on_save
        TimeLine.create(item: self) if self.published && self.published_changed?
    end
end