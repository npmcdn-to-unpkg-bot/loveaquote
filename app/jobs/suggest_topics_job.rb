class SuggestTopicsJob < Struct.new(:id)
  def perform
    quote = Quote.find(id)
    words = quote.text.split(" ")
    Topic.all.each do |topic|
      words.each do |word|
        word = cleanup_word(word)
        if (word.downcase == topic.name.downcase || find_alias_match(topic, word)) && !QuoteTopic.exists?(quote_id: quote.id, topic_id: topic.id)
          QuoteTopicSuggestion.create(quote_id: quote.id, topic_id: topic.id)
        end
      end
    end

  end
  
  def find_alias_match(topic, word)
    topic.topic_aliases.each do |topic_alias|
      if word.downcase == topic_alias.name.downcase
        return true
      end
    end
    nil
  end

  def cleanup_word(word)
    word.chop! if word[-1] == "'"
    word.chop! if word[-1] == "."
    word.chop! if word[-1] == ","
    word.chop! if word[-1] == ";"
    return word
  end

end