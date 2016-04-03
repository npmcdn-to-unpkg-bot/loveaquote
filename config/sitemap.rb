SitemapGenerator::Sitemap.default_host = "https://www.loveaquote.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all authors:

  Person.published.each do |person|
    add person_path(person, format: :html), :lastmod => person.updated_at
  end

  Book.published.each do |book|
    add book_path(book, format: :html), :lastmod => book.updated_at
  end

  Movie.published.each do |movie|
    add movie_path(movie, format: :html), :lastmod => movie.updated_at
  end

  TvShow.published.each do |tv_show|
    add tv_show_path(tv_show, format: :html), :lastmod => tv_show.updated_at
  end

  Character.published.each do |character|
    add character_path(character, format: :html), :lastmod => character.updated_at
  end

  Topic.published.each do |topic|
    add topic_path(topic, format: :html), :lastmod => topic.updated_at
  end

  TopicCombination.all.each do |topic|
    add topics_topic_combination_path(topic, format: :html), :lastmod => topic.updated_at
  end
end
