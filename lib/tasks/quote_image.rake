namespace :quote_image do
    task :generate => :environment do
        include ActionView::Helpers::TextHelper
        
        quote = Quote.first
        source = quote.source.name
        
        offset = rand(ColorScheme.count)
        color_scheme = ColorScheme.offset(offset).first
        
        #Generate quote Image
        quote_font_size = 30
        quote_padding = 10
        source_name_font_size = 30
        source_name_padding = 60
        laq_font_size = 16
        laq_padding = 80
        
        quote_image = Magick::Image.new(600,400) {
            self.background_color = "##{color_scheme.background_color}"
            self.quality = 100
        }

        draw = Magick::Draw.new
        draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

        draw.pointsize = quote_font_size
        draw.gravity = Magick::CenterGravity
        
        text = do_word_wrap("I do not think much of a man who is not wiser today than he was yesterday. I do not think much of a man who is not wiser today than he was yesterday.", 40)
        position = calculate_position(400, text.split("\n").count, quote_font_size, quote_padding, source_name_font_size, source_name_padding, laq_font_size, laq_padding)

        text.split("\n").each do |row|
            draw.annotate(quote_image, 580, 54, 10, position, row) {
                self.fill = "##{color_scheme.foreground_color}"
            }
            position += (quote_font_size + quote_padding)
        end
        
        position += (source_name_padding - quote_padding)
      
        draw.pointsize = source_name_font_size
        draw.annotate(quote_image, 580, 54, 10, position, "Deepak Kundu") {
            self.fill = "##{color_scheme.foreground_color}"
        }
        
        position += laq_padding    
        draw.pointsize = laq_font_size
        draw.annotate(quote_image, 580, 25, 10, position, "www.LOVEAQUOTE.com") {
            self.fill = "##{color_scheme.foreground_color}"
        }
        
        save_quote_image(quote_image, quote)
    end
    
    def do_word_wrap(text, line_width)
        word_wrap(text, line_width: line_width)
    end
    
    def calculate_position(height, lines, quote_font_size, quote_padding, source_name_font_size, source_name_padding, laq_font_size, laq_padding)
        (height - (lines*quote_font_size) - (lines - 1)*(quote_padding) - source_name_font_size - source_name_padding - laq_font_size - laq_padding)/2
    end
    
    def save_quote_image(quote_image, quote)
        Thread.new do
            FileUtils.mkdir_p(Rails.root + "public/generatedimages/quotes")
            quote_image.write(Rails.root.join("public/generatedimages/quotes/#{quote.id}.jpg"))
            quote.image = Rails.root.join("public/generatedimages/quotes/#{quote.id}.jpg").open
            quote.save
        end
    end
end