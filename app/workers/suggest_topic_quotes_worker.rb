class SuggestTopicQuotesWorker

  def perform(id)
    topic = Topic.find(id)
    Quote.all.find_in_batches do |quotes|
      quotes.each do |quote|
        words = quote.text.split(" ")
        words.each do |word|
          word = cleanup_word(word)
          if word.downcase == topic.name.downcase && !QuoteTopic.exists?(quote_id: quote.id, topic_id: topic.id)
            QuoteTopicSuggestion.create(quote_id: quote.id, topic_id: topic.id)
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