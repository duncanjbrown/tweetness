require 'spec_helper'
require 'client.rb'
require 'tweet.rb'

describe BrowserTwitter::Client do 

  before(:all) do 
    f = File.open('test/data/test_tweets', 'r')
    @cached_tweets = Marshal.load(f)
  end

  describe "#find_url" do 

    it "identifies urls" do 
      tweet = create(:tweet, :with_url)
      tweet.find_url.length.should be 1

      tweet = create(:tweet)
      tweet.find_url.length.should be 0
    end

    it "trims retweets (ie urls ending in :)" do 
      tweet = create(:tweet, :retweet)
      tweet.find_url.length.should be 0
    end
  end


end
