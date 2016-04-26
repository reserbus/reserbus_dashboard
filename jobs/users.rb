require 'rest-client'

SCHEDULER.every '10m', first_in: 0 do
  response = Dataclip::Api.items("***REMOVED***")
  row = response.first

  send_event('users', { current: row.fetch("count") })
end
