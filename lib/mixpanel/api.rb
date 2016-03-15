require 'mixpanel_client'

module Mixpanel
  class Api
    def initialize
      @client = Mixpanel::Client.new(
        api_key:    ENV['MIXPANEL_API_KEY'],
        api_secret: ENV['MIXPANEL_API_SECRET']
      )
    end

    def segmentation(event, properties, from_date, to_date)
      @client.request(
        'segmentation/',
        event: event,
        type: "general",
        on: properties,
        to_date: to_date,
        from_date: from_date,
        unit: "day"
      )["data"]["values"]
    end

    def events(events, from_date, to_date)
      @client.request(
        'events/',
        event:     events,
        type:      "general",
        unit:      "day",
        from_date: from_date,
        to_date:   to_date
      )
    end
  end
end
