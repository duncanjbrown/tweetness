require 'spec_helper'
require 'client.rb'
require 'twitter_client.rb'

describe BrowserTwitter::Client do 

  before(:all) do 
    f = File.open('test/data/test_tweets', 'r')
    @cached_tweets = Marshal.load(f)
  end

  before(:each) do 
    @twitter = double('BrowserTwitter::Twitter', load_tweets: @cached_tweets)
    @client = BrowserTwitter::Client.new(@twitter)
  end

  describe '#get_tweets' do 
    it "returns a bunch of tweets" do
      tweets = @client.get_tweets
      tweets.count.should be > 1
    end
  end

  describe '#save_tweet' do 
    it "persists the tweet to the db" do 
      Tweet.count.should be 0
      tweets = @client.get_tweets
      @client.save_tweet(tweets.first)
      Tweet.count.should be 1
    end 

    it "only saves a tweet with a url" do 
      tweet = build(:twitter_tweet)
      t = @client.save_tweet(tweet)
      Tweet.count.should be 0
    end
  end

  describe "#get_tweets!" do 

    it "fetches a bunch of tweets and saves them to the database" do 
      Tweet.count.should be 0
      collected_count = @client.get_tweets.count # get the count
      @client.get_tweets!
      Tweet.count.should > 100
    end
     
  end

  describe "#update_feed!" do 
    it "writes an xml file to disk" do 
      @client.get_tweets!
      @client.update_feed!
    end
  end

end
