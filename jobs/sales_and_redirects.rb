client = Mixpanel::Api.new

current_sales = 0
current_redirects = 0

SCHEDULER.every '10m' do
  last_sales = current_sales
  last_redirects = current_redirects
  data = client.events(["Purchase Complete", "Purchase redirect"])
  current_sales = data["data"]["values"]["Purchase Complete"].values.first
  current_redirects = data["data"]["values"]["Purchase redirect"].values.first
  send_event('sales', { current: current_sales, last: last_sales })
  send_event('redirects', { current: current_redirects, last: last_redirects })
end
