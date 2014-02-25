require 'rss'

module BrowserTwitter 
  class Feed

    def print 
      rss = RSS::Maker.make("2.0") do |maker|
        maker.channel.author = "matz"
        maker.channel.link = "http://thebrowser.com"
        maker.channel.description = "http://thebrowser.com"
        maker.channel.updated = Time.now.to_s
        maker.channel.about = "http://www.ruby-lang.org/en/feeds/news.rss"
        maker.channel.title = "Example Feed"

        maker.items.new_item do |item|
          item.link = "http://www.ruby-lang.org/en/news/2010/12/25/ruby-1-9-2-p136-is-released/"
          item.title = "Ruby 1.9.2-p136 is released"
          item.updated = Time.now.to_s
        end
      end
    end

  end 
end
