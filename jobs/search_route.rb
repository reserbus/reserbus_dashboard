class Interest
  def initialize
    @mixpanel = Mixpanel::Api.new
  end

  def in_routes
    # Populate the graph with some random points
    data = @mixpanel.segmentation("Interest in Route", 'properties["Destination"]')
    points = []
    data.each do |k,v|
      points << { x: k, y: v.values.first }
    end
    points
  end
end

interest = Interest.new

SCHEDULER.every '10m', :first_in => 0 do
  points = interest.in_routes
  send_event('destination', points: points)
end

