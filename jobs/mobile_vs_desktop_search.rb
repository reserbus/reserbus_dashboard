client = Mixpanel::Api.new

SCHEDULER.every '10m', :first_in => 0 do
  today = Date.today.strftime
  data = client.segmentation("Purchase Complete", 'properties["product"]', today, today)
  first_current = data["web"].values.first
  second_current = data["web-mobile"].values.first
  send_event('mobilevsdesktop', first_current: first_current, second_current: second_current)
end
