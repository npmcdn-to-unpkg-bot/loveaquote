every 1.day, :at => '11:30 pm' do
  rake "-s sitemap:refresh"
end

every 1.day, :at => '00:30 am' do
  rake "-s quote_share_count:correct"
end

every 5.minutes do
  rake "-s generate_social_images:all"
end
