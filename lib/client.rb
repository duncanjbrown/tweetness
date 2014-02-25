module BrowserTwitter 

  class Client

    def initialize(twitter)
      @twitter = twitter
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
      @twitter.load_tweets
    end

    def get_tweets!
      get_tweets.map { |t| save_tweet(t) }
    end

  end
end
