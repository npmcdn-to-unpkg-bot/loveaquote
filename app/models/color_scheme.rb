class ColorScheme < ActiveRecord::Base
    validates :background_color, presence: true, blank: false
    
    validates_uniqueness_of :background_color, scope: :foreground_color
    
    before_validation :add_foreground_color
    before_save :clean_up
    
    def add_foreground_color
        self.foreground_color = "FFFFFF" if self.foreground_color.blank?
    end
    
    def clean_up
        self.foreground_color = self.foreground_color[1..-1] if self.foreground_color[0] == "#"
        self.background_color = self.background_color[1..-1] if self.background_color[0] == "#"
    end
end
