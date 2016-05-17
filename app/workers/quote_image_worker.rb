class QuoteImageWorker
    include Sidekiq::Worker
    include ActionView::Helpers::TextHelper
    
    def perform(id)
        quote = Quote.find(id)
        quote.generate_slug unless quote.slug.present?
        offset = rand(ColorScheme.count)
        color_scheme = ColorScheme.offset(offset).first
        
        #Generate quote Image
        quote_font_size = 60
        quote_padding = 20
        source_name_font_size = 60
        source_name_padding = 120

        quote_image = Magick::Image.new(1200,600) {
            self.background_color = "##{color_scheme.background_color}"
            self.quality = 100
        }

        draw = Magick::Draw.new
        draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular-webfont.ttf"
        
        draw.pointsize = quote_font_size
        draw.gravity = Magick::CenterGravity
        
        text = do_word_wrap(quote.text, 38)
        position = calculate_position(600, text.split("\n").count, quote_font_size, quote_padding, source_name_font_size, source_name_padding)

        text.split("\n").each do |row|
            draw.annotate(quote_image, 1160, 108, 20, position, row) {
                self.fill = "##{color_scheme.foreground_color}"
            }
            position += (quote_font_size + quote_padding)
        end
        
        position += (source_name_padding - quote_padding)
      
        draw.pointsize = source_name_font_size
        draw.annotate(quote_image, 1160, 108, 20, position, quote.source.name) {
            self.fill = "##{color_scheme.foreground_color}"
        }
        
        save_quote_image(quote_image, quote)
        expire_cache
    end
    
    def do_word_wrap(text, line_width)
        word_wrap(text, line_width: line_width)
    end
    
    def calculate_position(height, lines, quote_font_size, quote_padding, source_name_font_size, source_name_padding)
        (height - (lines*quote_font_size) - (lines - 1)*(quote_padding) - source_name_font_size - source_name_padding)/2
    end
    
    def save_quote_image(quote_image, quote)
        require 'fileutils'
        Thread.new do
            FileUtils.mkdir_p(Rails.root + "public/generatedimages/quotes")
            quote_image.write(Rails.root.join("public/generatedimages/quotes/#{quote.slug}.jpg"))
            quote.image = Rails.root.join("public/generatedimages/quotes/#{quote.slug}.jpg").open
            ActiveRecord::Base.no_touching do
                quote.save
            end
            FileUtils.rm(Rails.root.join("public/generatedimages/quotes/#{quote.slug}.jpg"))
        end
    end
    
    def expire_cache
        Rails.cache.delete("quotes_with_images")
    end
end