class SocialImageWorker
  include Sidekiq::Worker
  include ActionView::Helpers::TextHelper

  def perform(class_name, id)
    source = class_name.constantize.find(id)

    if source
      two_lines = "Abraham Lincoln Abraham Lincoln Abraham Lincoln"
      source_name = word_wrap(two_lines + " " + "Quotes", line_width: 22)
      
      source_line_count = source_name.split("\n").count
      
      case source_line_count
      when 1
        facebook_position = 260
        google_plus_position = 202
        twitter_position = 246
      when 2
        facebook_position = 195
        google_plus_position = 144
        twitter_position = 182
      when 3
        facebook_position = 132
        google_plus_position = 86
        twitter_position = 118
      when 4
        facebook_position = 68
        google_plus_position = 28
        twitter_position = 54
      end

      #Generate Facebook Image
      facebook_image = Magick::Image.new(1200,627) {
        self.background_color = "#4A525F"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 108
      draw.gravity = Magick::CenterGravity
      source_name.split("\n").each do |row|
        draw.annotate(facebook_image, 1000, 108, 100, facebook_position, row) {
          self.fill = "#FFFFFF"
        }
        facebook_position += 128
      end

      #Generate Google Plus Image
      google_plus_image = Magick::Image.new(1200, 500) {
        self.background_color = "#4A525F"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 96
      draw.gravity = Magick::CenterGravity
      source_name.split("\n").each do |row|
        draw.annotate(google_plus_image, 1000, 108, 100, google_plus_position, row) {
          self.fill = "#FFFFFF"
        }
        google_plus_position += 116
      end

      #Generate Twitter Image
      twitter_image = Magick::Image.new(1200,600) {
        self.background_color = "#4A525F"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 108
      draw.gravity = Magick::CenterGravity
      source_name.split("\n").each do |row|
        draw.annotate(twitter_image, 1000, 108, 100, twitter_position, row) {
          self.fill = "#FFFFFF"
        }
        twitter_position += 116
      end

      require 'fileutils'
      Thread.new do
        FileUtils.mkdir_p(Rails.root + "public/generatedimages/facebook/#{class_name.downcase}")
        FileUtils.mkdir_p(Rails.root + "public/generatedimages/google_plus/#{class_name.downcase}")
        FileUtils.mkdir_p(Rails.root + "public/generatedimages/twitter/#{class_name.downcase}")

        facebook_image.write(Rails.root.join("public/generatedimages/facebook/#{class_name.downcase}/#{source.slug}.jpg"))
        google_plus_image.write(Rails.root.join("public/generatedimages/google_plus/#{class_name.downcase}/#{source.slug}.jpg"))
        twitter_image.write(Rails.root.join("public/generatedimages/twitter/#{class_name.downcase}/#{source.slug}.jpg"))
        
        social_image = SocialImage.find_or_create_by(source_type: class_name, source_id: source.id)
        
        social_image.facebook = Rails.root.join("public/generatedimages/facebook/#{class_name.downcase}/#{source.slug}.jpg").open
        social_image.google_plus = Rails.root.join("public/generatedimages/google_plus/#{class_name.downcase}/#{source.slug}.jpg").open
        social_image.twitter = Rails.root.join("public/generatedimages/twitter/#{class_name.downcase}/#{source.slug}.jpg").open
        
        social_image.save

        FileUtils.rm(Rails.root.join("public/generatedimages/facebook/#{class_name.downcase}/#{source.slug}.jpg"))
        FileUtils.rm(Rails.root.join("public/generatedimages/google_plus/#{class_name.downcase}/#{source.slug}.jpg"))
        FileUtils.rm(Rails.root.join("public/generatedimages/twitter/#{class_name.downcase}/#{source.slug}.jpg"))
      end
    end

  end
end