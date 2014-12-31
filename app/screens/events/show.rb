module Events
  class Show < ProMotion::Screen
    include TimeHelpers
    title 'Event'

    attr_accessor :event

    def on_load
      @layout = Events::ShowLayout.new
      self.view = @layout.view
      @layout.add_constraints

      @title = @layout.get(:event_title)
      @title.text = @event.title

      @date = @layout.get(:event_date)
      @date.text = humanized_date(@event.start_time)

      @time = @layout.get(:event_time)
      @time.text = start_end_time

      @location = @layout.get(:event_location)
      @location.text = @event.venue_title

      @description = @layout.get(:event_description)
      @description.text = @event.event_description

      @venue = @layout.get(:venue)
      @venue.text = @event.venue_details

      setup_map
    end

    def start_end_time
      "from #{humanized_time(@event.start_time)} to #{humanized_time(@event.end_time)}"
    end

    def setup_map
      if @event.venue_longitude && @event.venue_latitude
        @map = @layout.get(:venue_map)
        location = CLLocationCoordinate2DMake(@event.venue_latitude, @event.venue_longitude)
        pin = MapAnnotation.alloc.initWithCoordinates(location, title: @event.venue_title, subTitle: @event.venue_address)
        @map.addAnnotation(pin)

        region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.1, 0.1)) 
        @map.setRegion(region, animated: true)
      end
    end
  end
end
