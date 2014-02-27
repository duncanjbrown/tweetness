require 'rss'

module BrowserTwitter 
  class Feed

    def build(tweets)
      @rss = ::RSS::Maker.make("2.0") do |maker|

        maker.channel.author = "duncanjbrown"
        maker.channel.link = "http://thebrowser.com"
        maker.channel.description = "URLs From The Browser's Twitter Feed"
        maker.channel.updated = Time.now.to_s
        maker.channel.about = "http://thebrowser.com"
        maker.channel.title = "URLs From The Browser's Twitter Feed"

        tweets.each do |t|
          maker.items.new_item do |i|
            next if !t.url || !t.url.first
            i.title = "#{t.user} #{t.url.first}"
            i.link =  t.url.first
            i.guid.content = t.url.first
            i.guid.isPermaLink = true
            i.description = "#{t.user}: #{t.text}"
            i.date = t.date.to_s
          end
        end
      end
    end 

    def items
      @rss.items
    end

    def to_xml(filename)
      @rss.to_s
    end
  end
end
