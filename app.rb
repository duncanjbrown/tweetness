#!/usr/bin/env ruby

require 'twitter'
Dir["./lib/*.rb"].each {|file| require file }

module BrowserTwitter 

  class Client

    def save_tweet(tweet)
      Tweet.create( 
        :text => tweet.text,
        :url  => 'not yet',
        :tweet_id => tweet.id,
        :user => tweet.user.username,
        :date => tweet.created_at )
    end

    def get_tweets
      @twitter ||= Twitter.new  
      tweets = @twitter.load_tweets  
      tweets.map { |t| save_tweet(tweet) }
    end

  end
end
