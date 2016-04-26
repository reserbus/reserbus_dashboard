require 'rest-client'

SCHEDULER.every '5s' do
  response = Dataclip::Api.items("***REMOVED***")
  items = response.map do |row|
    {
      label: row.fetch("transporter_name"),
      value: row.fetch("purchase_count")
    }
  end

  send_event('internal_transporters', { items: items })
end
