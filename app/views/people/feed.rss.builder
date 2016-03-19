#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "LoveAQuote People Feed"
    xml.description "The Quote Lover's Community"
    xml.link "#{people_url(format: :html)}"
    xml.language "en"

    for timeline in @timelines
      if timeline.item
        xml.item do
          xml.title timeline.item.name + " Quotes"
          xml.pubDate timeline.created_at.to_s(:rfc822)
          xml.link model_url(timeline.item, format: :html)
          xml.guid model_url(timeline.item, format: :html)
        end
      end
    end
  end
end