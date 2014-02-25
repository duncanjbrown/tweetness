require 'date'
FactoryGirl.define do

  factory :tweet do 
    tweet_id "123"
    user     "username"
    date      Time.now.strftime('%Y-%m-%d %H:%M')
    text      "text of tweet"
    url       "url"
  end

end
