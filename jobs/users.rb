require 'rest-client'

SCHEDULER.every '10m', first_in: 0 do
  response = Dataclip::Api.items(ENV['USERS_ID'])
  row = response.first

  send_event('users', { current: row.fetch("count") })
end
