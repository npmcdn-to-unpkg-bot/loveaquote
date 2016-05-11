namespace :quote_image do
    task :generate => :environment do
        include ActionView::Helpers::TextHelper
        
        quote = Quote.first
        source = quote.source.name
        
        offset = rand(ColorScheme.count)
        color_scheme = ColorScheme.offset(offset).first
        
        #Generate Facebook Image
        facebook_image = Magick::Image.new(600,400) {
            self.background_color = "##{color_scheme.background_color}"
            self.quality = 100
        }

        draw = Magick::Draw.new
        draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

        draw.pointsize = 30
        draw.gravity = Magick::CenterGravity
        
        text = do_word_wrap("I do not think much of a man who is not wiser today than he was yesterday.", 40)
        facebook_position = calculate_position(text.split("\n").count, 400, 30, 10)

        text.split("\n").each do |row|
            draw.annotate(facebook_image, 580, 54, 10, facebook_position, row) {
                self.fill = "##{color_scheme.foreground_color}"
            }
            facebook_position += 40
        end
      
        draw.annotate(facebook_image, 580, 54, 10, facebook_position + 20, "Deepak Kundu") {
            self.fill = "##{color_scheme.foreground_color}"
        }
            
        draw.pointsize = 20
        draw.annotate(facebook_image, 580, 25, 10, facebook_position + 100, "www.LoveAQuote.com") {
            self.fill = "##{color_scheme.foreground_color}"
        }
        
        Thread.new do
            FileUtils.mkdir_p(Rails.root + "public/generatedimages/facebook/quotes")
            facebook_image.write(Rails.root.join("public/generatedimages/facebook/#{quote.id}.jpg"))
        end
    end
    
    def do_word_wrap(text, line_width)
        word_wrap(text, line_width: line_width)
    end
    
    def calculate_position(lines, height, font_size, padding)
        (height - font_size - (lines)*(font_size + padding) - padding*1.5 - font_size - padding - 24)/2
    end
end