require 'twitter'
require 'yaml'

module BrowserTwitter
  class Twitter 

    def initialize 
      config = YAML.load_file('config/twitter.yml');
      @client = ::Twitter::REST::Client.new(config["credentials"])
    end

    def load_tweets
      options = { count: 200 }
      if latest_id 
        options[:since_id] = latest_id
      end
      @client.home_timeline(options)
    end

    def latest_id 
      t = Tweet.last
      if t 
        return t.tweet_id
      else 
        return nil
      end
    end

  end

end

