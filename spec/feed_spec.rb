require 'spec_helper'
require 'feed.rb'

describe BrowserTwitter::Feed do 

  before(:each) do 
    @feed = BrowserTwitter::Feed.new
  end

  describe "#build" do 
    it "builds a feed" do 
      100.times do |i|
        create(:tweet, :with_url)
      end
      Tweet.all.count.should be 100
      @feed.build(Tweet.all)  
      @feed.items.count.should be 100  
    end

    it "survives a malformed tweet" do 
      create(:tweet) # without url
      @feed.build(Tweet.all)  
    end
  end
end