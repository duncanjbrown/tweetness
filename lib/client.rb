module BrowserTwitter 

  class Client

    def initialize(twitter)
      @twitter = twitter
    end

    def save_tweet(tweet)
      Tweet.create( 
        :text => tweet.text,
        :url  => 'not yet',
        :tweet_id => tweet.id,
        :user => tweet.user.username,
        :date => tweet.created_at )
    end

    def get_tweets
      @twitter.load_tweets
    end

    def get_tweets!
      get_tweets.map { |t| save_tweet(t) }
    end

  end
end
