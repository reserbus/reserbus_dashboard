#!/usr/bin/env ruby
require 'rest-client'
require 'json'

# Get info from the App Store of your App: 
# Last version Average and Voting
# All time Average and Voting
# 
# This job will track average vote score and number of votes  
# of your App by scraping the App Store website.

# Config
APP_ID = '884367907'
APP_COUNTRY = 'mx'

client = RestClient

SCHEDULER.every '30m', :first_in => 0 do |job|
  res = client.get("http://itunes.apple.com/lookup?id=#{APP_ID}&country=#{APP_COUNTRY}")

  result = JSON.parse(res)['results'][0]

  data = {}
  data["rating_average"] = result['averageUserRating']
  data["rating_count"] = result['userRatingCount']

  send_event('ios_app_store_rating', data)
end
