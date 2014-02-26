require 'date'
require 'faker' 
require 'ostruct'

FactoryGirl.define do

  factory :tweet do 
    tweet_id "123"
    user     "username"
    date      Time.now.strftime('%Y-%m-%d %H:%M')
    text      {Faker::Lorem.characters(rand(25..140))}
    url       nil

    trait :with_url do 
      text Faker::Internet.url
      url { [Faker::Internet.url] }
    end

    trait :retweet do 
      after(:create) do |tweet| 
        tweet.text = 'RT @thing: ' + tweet.text
      end
    end
  end

  factory :twitter_tweet, class: OpenStruct do 
    id "123"
    user      { OpenStruct.new(username: "username") }
    text      { Faker::Lorem.characters(rand(25..140)) }
    date      Time.now.strftime('%Y-%m-%d %H:%M')

    trait :with_url do 
      text Faker::Internet.url
    end

  end


end
