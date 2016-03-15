client = Mixpanel::Api.new

SCHEDULER.every '10m', :first_in => 0 do
  today = Date.today.strftime
  data = client.segmentation("Purchase redirect", 'properties["Departure Line"]', today, today)
  line_more_redirected = data.reduce(['', 0]) do |max_redirections, (line, line_hash)|
    line_redirections = line_hash.values.first
    max_redirections.last <  line_redirections ? [line, line_redirections] : max_redirections
  end
  send_event('more_redirected', {title: line_more_redirected.first,  current: line_more_redirected.last} )
end
