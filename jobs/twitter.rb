require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'oaPfw1CLIxWAAOXqFf0DHD5mw'
  config.consumer_secret = '2k1Ds81IyE46eJiNafL2Ntr7Av2YGmmkdppGyX0IfUlv6L7LoB'
  config.access_token = '126397269-mr2pxmNW7X8Wo9j1KP7V6dsUhT1NWa8ZCeMuTsHS'
  config.access_token_secret = '1wJEuHUOHr5vIoo7nm5s9814C0MGmD6HVaTHOvXsVp0fB'
end

search_term = [URI::encode('#devLDZ'), URI::encode('#scareCrew'), URI::encode('#guildWebDev') ] 

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    term = search_term.sample
    tweets = twitter.search("#{term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end

