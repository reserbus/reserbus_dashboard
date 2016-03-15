require 'active_support/all'

client = Mixpanel::Api.new

current_sales = 0
current_redirects = 0
last_sales = 0
last_redirects = 0

SCHEDULER.every '1d', :first_in => 0 do
  last_week = (Date.today - 1.week).strftime
  old_data = client.events(["Purchase Complete", "Purchase redirect"], last_week, last_week)
  last_sales = old_data["data"]["values"]["Purchase Complete"].values.first
  last_redirects = old_data["data"]["values"]["Purchase redirect"].values.first
end

SCHEDULER.every '10m', :first_in => 0 do
  today = Date.today.strftime
  data = client.events(["Purchase Complete", "Purchase redirect"], today, today)
  current_sales = data["data"]["values"]["Purchase Complete"].values.first
  current_redirects = data["data"]["values"]["Purchase redirect"].values.first
  send_event('sales', { current: current_sales, last: last_sales })
  send_event('redirects', { current: current_redirects, last: last_redirects })
end
