require 'spec_helper'
require 'browser_twitter.rb'

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

    it "returns the latest id when tweets are available" do 
      tweet = create(:tweet)
      Tweet.count.should be 1
      Tweet.last.tweet_id.should eq "123"
    end
  
  end


end
