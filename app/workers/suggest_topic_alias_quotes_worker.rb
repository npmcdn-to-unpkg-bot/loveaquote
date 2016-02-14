class SuggestTopicAliasQuotesWorker
  include Sidekiq::Worker

  def perform(id)
    topic_alias = TopicAlias.find(id)
    Quote.all.find_in_batches do |quotes|
      quotes.each do |quote|
        words = quote.text.split(" ")
        words.each do |word|
          word = cleanup_word(word)
          if word.downcase == topic_alias.name.downcase
            QuoteTopicSuggestion.create(quote_id: quote.id, topic_id: topic_alias.topic.id)
            break
          end
        end
      end
    end
  end

  def cleanup_word(word)
    word.chop! if word[-1] == "'"
    word.chop! if word[-1] == "."
    word.chop! if word[-1] == ","
    word.chop! if word[-1] == ";"
    word.chop! if word[-1] == ":"
    return word
  end

end