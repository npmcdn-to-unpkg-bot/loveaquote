#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "LoveAQuote"
    xml.description "The Quote Lover's Community"
    xml.link "#{root_url}"
    xml.language "en"

    for timeline in @timelines
      xml.item do
        xml.title timeline.item.name + "Quotes"
        xml.pubDate timeline.created_at.to_s(:rfc822)
        xml.link model_url(timeline.item, format: :html)
        xml.guid timeline.id
      end
    end
  end
end