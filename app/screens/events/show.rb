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

      setup_alerts
      setup_map
      setup_notifications
    end

    def start_end_time
      "from #{humanized_time(@event.start_time)} to #{humanized_time(@event.end_time)}"
    end

    def setup_alerts
      set_alert_text
      rmq(@layout.get(:alert_container)).on(:tap) do |sender|
        screen = Alerts::Edit.new(event: @event, nav_bar: true)
        self.navigationController.pushViewController(screen, animated: true)
      end
    end

    def set_alert_text
      if @event.alerts.length > 0
        text = @event.alerts.all.map{|a| a.alert_type.capitalize}.join(", ")
      else
        text = "No alerts"
      end

      @layout.get(:alert_settings).text = text
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

    def setup_notifications
      NSNotificationCenter.defaultCenter.tap do |dc|
        dc.addObserver(self, selector:'dataDidChange:',
        name:'MotionModelDataDidChangeNotification',
        object:nil)
      end
    end

    def dataDidChange notification
      set_alert_text
    end
  end
end
