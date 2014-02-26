module BrowserTwitter
  class Maintenance 

    def clip(n)
      if !Tweet.any?
        return nil
      end
      lowest_id = Tweet.highest_id - n
      Tweet.all( :id.lte => lowest_id ).destroy!
    end

  end
end
