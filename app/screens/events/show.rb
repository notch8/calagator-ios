module Events
  class MapView < UIView
    attr_accessor :event

    def rmq_build
      if @event.venue_longitude && event.venue_latitude
        rmq(self).apply_style(:map_container)
        map = MKMapView.alloc.init

        rmq(self).append(map).apply_style(:venue_map)

        location = CLLocationCoordinate2DMake(@event.venue_latitude, @event.venue_longitude)
        pin = MapAnnotation.alloc.initWithCoordinates(location, title: @event.venue_title, subTitle: @event.venue_address)
        map.addAnnotation(pin)

        region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.1, 0.1)) 
        map.setRegion(region, animated: true)
      end

    end
  end
  class TitleView < UIView
    include TimeHelpers
    attr_accessor :event

    def rmq_build
      container = rmq(self)

      container.append(UILabel).data(@event.title).apply_style(:event_title)

      container.append(UILabel, :line).nudge(d: 10)
      container.append(UILabel, :event_date).data(humanized_date(@event.start_time))
      container.append(UILabel, :event_time).data(start_end_time)
      container.append(UILabel, :event_location).data(@event.venue_title)
    end

    def sizeThatFits current_size
      height = [:event_title, :event_date, :event_time, :event_location].inject(0) do |sum, sym|
        frame = rmq(self).find(sym).frame
        frame_height = frame.h.to_i + frame.t.to_i
        frame_height
      end

      height += 10
      [rmq.device.width, height ]
    end

    private
      def start_end_time
        "from #{humanized_time(@event.start_time)} to #{humanized_time(@event.end_time)}"
      end
  end

  class ActionsView < UIView
    attr_accessor :event
    def rmq_build
      rmq(self).apply_style(:actions_container)
      container = rmq(self)

      add_alerts container
      container.append(UILabel, :line).nudge(d:10)
      add_series container
    end

    def add_alerts container
      container.append(UILabel, :label).data("Alert")
      container.append(UILabel, :right_chevron).nudge(u:14)

      if @event.alerts.length == 0
        text = "No alerts"
      else
        text = @event.alerts.all.map{|a| a.alert_type.capitalize}.join(", ")
      end

      container.append(UILabel, :setting).data(text)
    end

    def add_series container
      container.append(UILabel, :label).data("Series").nudge(d: 40)
      container.append(UILabel, :right_chevron).nudge(d: 26)
    end

  end

  class Show < ProMotion::Screen
    include TimeHelpers
    title 'Event'

    attr_accessor :event

    def on_load
      self.edgesForExtendedLayout = UIRectEdgeNone
      rmq.stylesheet = Events::ShowStylesheet
      rmq(self.view).apply_style :root_view

      add_title
      add_map
      add_actions
      #add_description
      #add_venue

      setup_notifications
    end

    def add_title
      title = TitleView.new
      title.event = @event
      rmq.append(title, :title_container)
    end

    def add_about
    end

    def add_map
      map = MapView.new
      map.event = @event
      rmq.append(map, :map_container)
    end

    def add_actions
      actions = ActionsView.new
      actions.event = @event
      rmq.append(actions, :actions_container)
    end

    def add_description
      rmq.append(UILabel).data(@event.event_description).apply_style(:event_description)
    end

    def add_venue
      rmq.append(UILabel).data(@event.venue_details).apply_style(:event_description)
    end


    def setup_notifications
      NSNotificationCenter.defaultCenter.tap do |dc|
        dc.addObserver(self, selector:'dataDidChange:',
                        name:'MotionModelDataDidChangeNotification',
                        object:nil)
      end
    end
    def cell_height_for(text, font=nil)
      puts "\n\n\nin chf"
      font ||= rmq.font.small
      if text
        constraintSize = [rmq.device.width - 40, 9999]
        label_size = text.sizeWithFont(font, constrainedToSize: constraintSize, lineBreakMode: UILineBreakModeWordWrap)
        puts "height: #{label_size.height}, text:"
        puts text
        label_size.height + 10
      else
        0
      end
    end

    def view_alerts args
      screen = Alerts::Edit.new(event: @event, nav_bar: true)
      self.navigationController.pushViewController(screen, animated: true)
    end

    def view_series args
      puts "view series"
    end

    def dataDidChange notification
      self.view.reloadData
    end
  end
end
