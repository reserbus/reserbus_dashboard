client = Mixpanel::Api.new

SCHEDULER.every '10m', :first_in => 0 do
  today = Date.today.strftime
  data = client.segmentation("Purchase Complete", 'properties["product"]', today, today)
  first_current = ["web", "undefined"].inject(0) { |sum, product|
    sum + data[product].try(:values).try(:first).to_i
  }
  second_current = ["web-mobile", "ios-cordova", "android-cordova"].inject(0) { |sum, product|
    sum + data[product].try(:values).try(:first).to_i
  }
  send_event('mobilevsdesktop', first_current: first_current, second_current: second_current)
end
