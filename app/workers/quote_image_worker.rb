class QuoteImageWorker
    include ActionView::Helpers::TextHelper
    
    def perform(id)
        quote = Quote.find(id)
        
        quote.generate_slug unless quote.slug.present?
        offset = rand(ColorScheme.count)
        color_scheme = ColorScheme.offset(offset).first
        
        text = do_word_wrap(quote.text, 36)
        lines = text.split("\n").count
        
        #Generate quote Image
        top_bottom_padding = 100
        quote_font_size = 60
        quote_padding = 20
        source_name_font_size = 60
        source_name_padding = 120        
        image_width = 1200
        calculated_image_height = (top_bottom_padding*2 + source_name_font_size + source_name_padding + (lines)*quote_font_size + (lines-1)*quote_padding)
        image_height = [600, calculated_image_height].max

        position = calculate_position(image_height, text.split("\n").count, quote_font_size, quote_padding, source_name_font_size, source_name_padding)
        
        quote_image = Magick::Image.new(1200,image_height) {
            self.background_color = "##{color_scheme.background_color}"
            self.quality = 100
            self.density = 300
        }

        draw = Magick::Draw.new
        draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular-webfont.ttf"
        
        draw.pointsize = quote_font_size
        draw.gravity = Magick::CenterGravity

        text.split("\n").each do |row|
            draw.annotate(quote_image, 1160, quote_font_size, 20, position, row) {
                self.fill = "##{color_scheme.foreground_color}"
            }
            position += (quote_font_size + quote_padding)
        end
        
        position += (source_name_padding - quote_padding)
      
        draw.pointsize = source_name_font_size
        draw.annotate(quote_image, 1160, source_name_font_size, 20, position, quote_source_name(quote)) {
            self.fill = "##{color_scheme.foreground_color}"
        }
        
        save_quote_image(quote_image, image_width, image_height, quote)
    end
    
    def do_word_wrap(text, line_width)
        word_wrap(text, line_width: line_width)
    end
    
    def calculate_position(height, lines, quote_font_size, quote_padding, source_name_font_size, source_name_padding)
        (height - (lines)*(quote_font_size) - (lines - 1)*(quote_padding) - source_name_font_size - source_name_padding)/2
    end
    
    def save_quote_image(quote_image, image_width, image_height, quote)
        require 'fileutils'
        Thread.new do
            FileUtils.mkdir_p(Rails.root + "public/generatedimages/quotes")
            quote_image.write(Rails.root.join("public/generatedimages/quotes/#{quote.slug}.jpg"))
            ActiveRecord::Base.no_touching do
                quote.image = Rails.root.join("public/generatedimages/quotes/#{quote.slug}.jpg").open
                quote.image_width = image_width
                quote.image_height = image_height
                quote.save
            end
            FileUtils.rm(Rails.root.join("public/generatedimages/quotes/#{quote.slug}.jpg"))
        end
    end
    
    def quote_source_name(quote)
        case quote.source.class.name
        when "Proverb"
            return "#{quote.source.name} Proverb"
        else
            return quote.source.name
        end
    end
end