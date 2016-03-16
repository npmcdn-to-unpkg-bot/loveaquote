class ColorScheme < ActiveRecord::Base
    validates :background_color, presence: true, blank: false
    validates :foreground_color, presence: true, blank: false
    
    validates_uniqueness_of :background_color, scope: :foreground_color
end
