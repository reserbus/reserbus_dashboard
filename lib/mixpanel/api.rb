require 'mixpanel_client'
require 'dotenv'

Dotenv.load

module Mixpanel
  class Api
    def initialize
      @client = Mixpanel::Client.new(
        api_key:    ENV['MIXPANEL_API_KEY'],
        api_secret: ENV['MIXPANEL_API_SECRET']
      )
    end

    def segmentation(event, properties)
      @client.request(
        'segmentation/',
        event: event,
        type: "general",
        on: properties,
        to_date: "2016-03-11",
        from_date: "2016-03-11",
        unit: "day"
      )["data"]["values"]
    end

    def events(events)
      @client.request(
        'events/',
        event:     events,
        type:      "general",
        unit:      "day",
        from_date: "2016-03-11",
        to_date:   "2016-03-11"
      )
    end


  end
end
