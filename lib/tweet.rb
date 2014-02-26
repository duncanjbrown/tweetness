require 'data_mapper'
require 'sqlite3'
require 'yaml'
require 'uri'
require 'net/http'

config = YAML.load_file('db/config.yml');
DataMapper.setup(:default, config["development"])

class Tweet
  include DataMapper::Resource

  property :id,         Serial
  property :user,      String  
  property :text,       Text    
  property :url,        Object
  property :date,        DateTime
  property :tweet_id,    String
  property :created_at, DateTime 

  def find_url
    url = URI.extract(self.text)
    url = url.select { |url| !url.end_with? ':' }
    if url 
      return url.map { |url| lengthen_url(url) }
    else
      return nil
    end
  end

  class << self 
    def highest_id
      Tweet.last.id
    end
  end

  private 
    def lengthen_url(url)
      begin
        uri = URI(url)
        Net::HTTP.new(uri.host, uri.port).get(uri.path).header['location']
      rescue
      end
    end

end

DataMapper.finalize
