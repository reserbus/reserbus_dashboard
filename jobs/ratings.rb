require 'rest-client'

SCHEDULER.every '10m', first_in: 0 do
  response = Dataclip::Api.items(ENV['RATINGS_ID'])
  row = response.first

  send_event('ratings', { current: row.fetch("count") })
end
