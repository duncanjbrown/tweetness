require 'yaml'

module BrowserTwitter 

  class Client

    def initialize(twitter, maintenance)
      @config = YAML.load_file( 'config/preferences.yml' )
      @twitter = twitter
      @maintenance = maintenance
    end

    def save_tweet(tweet)
      t = Tweet.new( 
        :text => tweet.text,
        :tweet_id => tweet.id,
        :user => tweet.user.username,
        :date => tweet.created_at )
      urls = t.find_url 
      if urls.any? 
        t.url = urls
        t.save!
        t
      else
      end
    end

    def get_tweets
      @twitter.load_tweets.reverse
    end

    def get_tweets!
      puts "Cleaning Database..."
      @maintenance.clip(@config['tweets'])
      puts "Loading Tweets..."
      get_tweets.map do |t| 
        print "."
        save_tweet(t) 
      end
      puts "\rWriting RSS Feed"
      update_feed!
      File.open('last_run', 'w') do |f|
        f.write( Time.new.inspect )
      end
    end

    def update_feed!
      feed = Feed.new.build(Tweet.all)
      File.open(@config["rss_file"], 'w') do |f|
        f.write(feed.to_s)
      end
    end

  end
end
