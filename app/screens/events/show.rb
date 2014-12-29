class EventAboutHeader < UIView
  def didMoveToWindow
    rmq(self).apply_style(:about_header)
  end
end

class EventSpacer < UIView
  def didMoveToWindow
    rmq(self).apply_style(:event_spacer)
  end
end


class EventMapCell < PM::TableViewCell
  def event= event
    if event.venue_longitude && event.venue_latitude
      @map ||= begin
        rmq(self).apply_style(:location_container)
        map = MKMapView.alloc.init

        rmq(self).append(map).apply_style(:venue_map)

        location = CLLocationCoordinate2DMake(event.venue_latitude, event.venue_longitude)
        pin = MapAnnotation.alloc.initWithCoordinates(location, title: event.venue_title, subTitle: event.venue_address)
        map.addAnnotation(pin)

        region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.1, 0.1)) 
        map.setRegion(region, animated: true)
      end
    end
  end
end

class EventTitleCell < PM::TableViewCell
  def title=(title)
    rmq.append(UILabel).data(title).apply_style(:event_title)
  end
end

class EventDetailCell < PM::TableViewCell
  include TimeHelpers
  def event=(event)
    rmq.append(UILabel, :event_date).data(humanized_date(event.start_time))

    time = "from #{humanized_time(event.start_time)} to #{humanized_time(event.end_time)}"
    @event_time_label ||= rmq.append(UILabel, :event_time)
    @event_time_label.data(time)

    @event_location_label ||= rmq.append(UILabel, :event_location)
    @event_location_label.data(event.venue_title)
  end

end

class EventReminderSummaryCell < PM::TableViewCell
  def event=(event)
    @alert_label ||= rmq.append(UILabel, :label).data("Alert")
    @right_cevron ||= rmq.append(UILabel, :right_chevron)

    if event.alerts.length == 0
      text = "No alerts"
    else
      text = event.alerts.all.map{|a| a.alert_type.capitalize}.join(", ")
    end
    @setting_label ||= rmq.append(UILabel, :setting)
    @setting_label.data(text)
  end
end

class EventSeriesSummaryCell < PM::TableViewCell
  def event=(event)
    @right_chevron ||= rmq.append(UILabel, :right_chevron)
    @series_label ||= rmq.append(UILabel, :label).data("Series")
  end
end

module Events
  class Show < ProMotion::TableScreen
    include TimeHelpers
    title 'Event'

    attr_accessor :event

    def on_load
      rmq.stylesheet = Events::ShowStylesheet
      NSNotificationCenter.defaultCenter.tap do |dc|
        dc.addObserver(self, selector:'dataDidChange:',
                        name:'MotionModelDataDidChangeNotification',
                        object:nil)
      end
    end

    def table_data
      [{
        title: '',
        title_view_height: 50,
        title_view: EventAboutHeader,
        cells: [
          {
            cell_class: EventTitleCell,
            height: 45,
            properties: {
              title: event.title
            }
          },
          {
            cell_class: EventDetailCell,
            height: 50,
            properties:{
              event: event
            }
          },
          {
            cell_class: EventMapCell,
            height: 200,
            properties: {
              event: event
            }
          },
        ]
      },
      {
        title: '',
        title_view_height: 50,
        title_view: EventSpacer,
        cells: [
          {
            cell_class: EventReminderSummaryCell,
            height: 50,
            action: :view_alerts,
            arguments: { event: event },
            properties: {
              event: event
            },
          },
          {
            cell_class: EventSeriesSummaryCell,
            height: 50,
            action: :view_series,
            arguments: { event: event },
            properties: {
              event: event
            }
          }
        ]
      }]
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


      #location_container = rmq.append(UIView, :location_container)
      #location_container.append(UILabel).data(@event.venue_title).apply_style(:venue_title)
      #if @event.venue_address
      #  location_container.append(UILabel).data(@event.venue_address).apply_style(:venue_address)
      #end

      #if @event.venue_details
      #  location_container.append(UILabel).data(@event.venue_details).apply_style(:venue_details)
      #end

      #rmq.append(UILabel, :event_description).data(@event.event_description)


    #end

  end
end
