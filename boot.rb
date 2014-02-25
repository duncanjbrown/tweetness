#/usr/bin/env ruby
Dir["./lib/*.rb"].each {|file| require file }

app = BrowserTwitter::Client.new(BrowserTwitter::Twitter)
