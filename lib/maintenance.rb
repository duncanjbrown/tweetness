module BrowserTwitter
  class Maintenance 

    def clip(n)
      lowest_id = Tweet.highest_id - n
      Tweet.all( :id.lte => lowest_id ).destroy!
    end

  end
end
