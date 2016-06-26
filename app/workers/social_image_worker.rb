class SocialImageWorker
  include ActionView::Helpers::TextHelper

  def perform(class_name, id)
    source = class_name.constantize.find(id)

    if source
      offset = rand(ColorScheme.count)
      color_scheme = ColorScheme.offset(offset).first

      if source.class.name == "Proverb"
        facebook_source_name = do_word_wrap(source.name + " Proverbs", 22)
        google_plus_source_name = do_word_wrap(source.name + " Proverbs", 22)
        twitter_source_name = do_word_wrap(source.name + " Proverbs", 22)
        pinterest_source_name = do_word_wrap(source.name + " Proverbs", 10)
      else
        facebook_source_name = do_word_wrap(source.name + " Quotes", 22)
        google_plus_source_name = do_word_wrap(source.name + " Quotes", 22)
        twitter_source_name = do_word_wrap(source.name + " Quotes", 22)
        pinterest_source_name = do_word_wrap(source.name + " Quotes", 10)
      end
      
      facebook_position = calculate_position(facebook_source_name.split("\n").count + 1, 627, 108, 20)
      google_plus_position = calculate_position(google_plus_source_name.split("\n").count + 1, 500, 96, 20)
      twitter_position = calculate_position(twitter_source_name.split("\n").count + 1, 600, 108, 20)
      pinterest_position = calculate_position(pinterest_source_name.split("\n").count + 1, 1128, 108, 20)

      #Generate Facebook Image
      facebook_image = Magick::Image.new(1200,627) {
        self.background_color = "##{color_scheme.background_color}"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 108
      draw.gravity = Magick::CenterGravity
      facebook_source_name.split("\n").each do |row|
        draw.annotate(facebook_image, 1000, 108, 100, facebook_position, row) {
          self.fill = "##{color_scheme.foreground_color}"
        }
        facebook_position += 128
      end
      
      draw.pointsize = 48
      draw.annotate(facebook_image, 1000, 50, 100, facebook_position + 50, "www.LoveAQuote.com") {
        self.fill = "##{color_scheme.foreground_color}"
      }

      #Generate Google Plus Image
      google_plus_image = Magick::Image.new(1200, 500) {
        self.background_color = "##{color_scheme.background_color}"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 96
      draw.gravity = Magick::CenterGravity
      google_plus_source_name.split("\n").each do |row|
        draw.annotate(google_plus_image, 1000, 108, 100, google_plus_position, row) {
          self.fill = "##{color_scheme.foreground_color}"
        }
        google_plus_position += 116
      end
      
      draw.pointsize = 48
      draw.annotate(google_plus_image, 1000, 50, 100, google_plus_position + 50, "www.LoveAQuote.com") {
        self.fill = "##{color_scheme.foreground_color}"
      }

      #Generate Twitter Image
      twitter_image = Magick::Image.new(1200,600) {
        self.background_color = "##{color_scheme.background_color}"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 108
      draw.gravity = Magick::CenterGravity
      twitter_source_name.split("\n").each do |row|
        draw.annotate(twitter_image, 1000, 108, 100, twitter_position, row) {
          self.fill = "##{color_scheme.foreground_color}"
        }
        twitter_position += 128
      end
      
      draw.pointsize = 48
      draw.annotate(twitter_image, 1000, 50, 100, twitter_position + 50, "www.LoveAQuote.com") {
        self.fill = "##{color_scheme.foreground_color}"
      }
      
      #Generate Pinterest Image
      pinterest_image = Magick::Image.new(736,1128) {
        self.background_color = "##{color_scheme.background_color}"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular-webfont.ttf"

      draw.pointsize = 108
      draw.gravity = Magick::CenterGravity
      pinterest_source_name.split("\n").each do |row|
        draw.annotate(pinterest_image, 636, 108, 50, pinterest_position, row) {
          self.fill = "##{color_scheme.foreground_color}"
        }
        pinterest_position += 116
      end
      
      draw.pointsize = 48
      draw.annotate(pinterest_image, 636, 50, 50, pinterest_position + 50, "www.LoveAQuote.com") {
        self.fill = "##{color_scheme.foreground_color}"
      }

      require 'fileutils'
      Thread.new do
        FileUtils.mkdir_p(Rails.root + "public/generatedimages/facebook/#{class_name.downcase}")
        FileUtils.mkdir_p(Rails.root + "public/generatedimages/google_plus/#{class_name.downcase}")
        FileUtils.mkdir_p(Rails.root + "public/generatedimages/twitter/#{class_name.downcase}")
        FileUtils.mkdir_p(Rails.root + "public/generatedimages/pinterest/#{class_name.downcase}")

        facebook_image.write(Rails.root.join("public/generatedimages/facebook/#{class_name.downcase}/#{source.slug}.jpg"))
        google_plus_image.write(Rails.root.join("public/generatedimages/google_plus/#{class_name.downcase}/#{source.slug}.jpg"))
        twitter_image.write(Rails.root.join("public/generatedimages/twitter/#{class_name.downcase}/#{source.slug}.jpg"))
        pinterest_image.write(Rails.root.join("public/generatedimages/pinterest/#{class_name.downcase}/#{source.slug}.jpg"))
        
        social_image = SocialImage.find_or_create_by(source_type: class_name, source_id: source.id)
        
        social_image.facebook = Rails.root.join("public/generatedimages/facebook/#{class_name.downcase}/#{source.slug}.jpg").open
        social_image.google_plus = Rails.root.join("public/generatedimages/google_plus/#{class_name.downcase}/#{source.slug}.jpg").open
        social_image.twitter = Rails.root.join("public/generatedimages/twitter/#{class_name.downcase}/#{source.slug}.jpg").open
        social_image.pinterest = Rails.root.join("public/generatedimages/pinterest/#{class_name.downcase}/#{source.slug}.jpg").open
        
        social_image.save

        FileUtils.rm(Rails.root.join("public/generatedimages/facebook/#{class_name.downcase}/#{source.slug}.jpg"))
        FileUtils.rm(Rails.root.join("public/generatedimages/google_plus/#{class_name.downcase}/#{source.slug}.jpg"))
        FileUtils.rm(Rails.root.join("public/generatedimages/twitter/#{class_name.downcase}/#{source.slug}.jpg"))
        FileUtils.rm(Rails.root.join("public/generatedimages/pinterest/#{class_name.downcase}/#{source.slug}.jpg"))
      end
    end
    
    sleep(5)
  end
  
  def do_word_wrap(text, line_width)
    word_wrap(text, line_width: line_width)
  end
  
  def calculate_position(lines, height, font_size, padding)
    (height - font_size - (lines-1)*(font_size + padding))/2
  end
end