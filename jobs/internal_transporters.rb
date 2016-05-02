require 'rest-client'

SCHEDULER.every '10m', first_in: 0 do
  response = Dataclip::Api.items(ENV['INTERNAL_TRANSPORTERS_ID'])
  items = response.map do |row|
    {
      label: row.fetch("transporter_name"),
      value: row.fetch("purchase_count")
    }
  end

  send_event('internal_transporters', { items: items })
end
