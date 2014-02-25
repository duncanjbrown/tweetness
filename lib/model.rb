require 'data_mapper'
require 'sqlite3'
require 'yaml'
require 'uri'

config = YAML.load_file('db/config.yml');
DataMapper.setup(:default, config["development"])

class Tweet
  include DataMapper::Resource

  property :id,         Serial
  property :user,      String  
  property :text,       Text    
  property :url,        Text
  property :date,        DateTime
  property :tweet_id,    String
  property :created_at, DateTime 

  def find_url
    url = URI.extract(self.text)
    if url 
      return url
    else
      return nil
    end
  end

end

DataMapper.finalize
