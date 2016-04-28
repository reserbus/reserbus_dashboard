#!/usr/bin/env ruby
require 'net/http'
require 'openssl'

# Average+Average Voting on an Android App
#
# This job will track the average vote score and number of votes on an app
# that is registered in the google play market by scraping the google play
# market website.
#
# There are two variables send to the dashboard:
# `google_play_voters_total` containing the number of people voted
# `google_play_average_rating` float value with the average votes

# Config
# ------
appPageUrl = 'https://play.google.com/store/apps/details?id=com.reserbus.Reserbus'

SCHEDULER.every '24h', :first_in => 0 do |job|
  puts "fetching App Store Rating for App: " + appPageUrl
  # prepare request
  http = Net::HTTP.new("play.google.com", Net::HTTP.https_default_port())
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE # disable ssl certificate check

  # scrape detail page of appPageUrl
  response = http.request( Net::HTTP::Get.new(appPageUrl) )

  if response.code != "200"
    puts "google play store website communication (status-code: #{response.code})\n#{response.body}"
  else
    # Version: ... aria-label="4 stars, 2180 Ratings"
    average_rating = response.body.scan( /meta content="([\d,.]+)" itemprop="ratingValue">/m)
    print "#{average_rating}\n"
    # <span class="rating-count">24 Ratings</span>
    voters_count = response.body.scan( /meta content="([\d,.]+)" itemprop="ratingCount">/m)
    print "#{voters_count}\n"

    data = {}
    data[:rating_average] = '%.1f' % average_rating[0][0]
    data[:rating_count] = '%.1f' % voters_count[0][0]

    print data
    send_event('android_score_rating', data)
  end
end
