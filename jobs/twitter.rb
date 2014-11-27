require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_SECRET'] 
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN'] 
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

