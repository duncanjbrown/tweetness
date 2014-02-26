require 'spec_helper'
require 'twitter_client.rb'

describe BrowserTwitter::Twitter do 

  before(:all) do 
    f = File.open('test/data/test_tweets', 'r')
    @cached_tweets = Marshal.load(f)
  end

  before(:each) do 
    @twitter = BrowserTwitter::Twitter.new
    allow(@twitter).to receive(:load_tweets).and_return @cached_tweets
  end

  describe "latest_id" do 

    it "returns nil when no tweets are available" do 
      Tweet.count.should be 0
      @twitter.latest_id.should be nil
    end

    it "returns an id when tweets are available" do 
      tweet = create(:tweet)
      Tweet.count.should be 1
      @twitter.latest_id.should eq "123"
    end
  
    it "returns the last-inserted ID when multiple tweets are available" do 
      tweet = create(:tweet, { tweet_id: "abc" })
      tweet = create(:tweet, { tweet_id: "def" })
      Tweet.count.should be 2
      @twitter.latest_id.should eq "def"
    end

  end


end
