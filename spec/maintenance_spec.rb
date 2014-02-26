require 'spec_helper'
require 'maintenance.rb'

describe BrowserTwitter::Maintenance do 

  before (:each) do 
    @maintenance = BrowserTwitter::Maintenance.new
  end

  it "cleans the 11th tweet from the db" do 
    11.times do |i| 
      create(:tweet, :with_url)
    end

    @maintenance.clip( 10 )

    Tweet.count.should be 10
  end

  it "lets fewer than 10 tweets rest undisturbed" do 
    9.times do |i| 
      create(:tweet, :with_url)
    end

    @maintenance.clip( 10 )

    Tweet.count.should be 9
  end

end