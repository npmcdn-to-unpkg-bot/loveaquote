class SocialImageWorker
  include Sidekiq::Worker
  include ActionView::Helpers::TextHelper

  def perform(class_name, id)
    source = class_name.constantize.find(id)

    if source
      source_name = word_wrap(source.name + " " + "Quotes", line_width: 24)

      #Generate Facebook Image
      facebook_image = Magick::Image.new(1200,627) {
        self.background_color = "#4A525F"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 108
      draw.gravity = Magick::CenterGravity
      source_name.split("/n").each do |row|
        draw.annotate(facebook_image, 1200, 627, 0, 0, row) {
          self.fill = "#FFFFFF"
        }
      end

      #Generate Google Plus Image
      google_plus_image = Magick::Image.new(1200, 500) {
        self.background_color = "#4A525F"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 108
      draw.gravity = Magick::CenterGravity
      draw.annotate(google_plus_image, 0, 0, 0, 0, source_name) {
        self.fill = "#FFFFFF"
      }

      #Generate Twitter Image
      twitter_image = Magick::Image.new(1200,600) {
        self.background_color = "##4A525F"
        self.quality = 100
      }

      draw = Magick::Draw.new
      draw.font = "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf"

      draw.pointsize = 108
      draw.gravity = Magick::CenterGravity
      draw.annotate(twitter_image, 0, 0, 0, 0, source_name) {
        self.fill = "#FFFFFF"
      }

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