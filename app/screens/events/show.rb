module Events
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
      add_description
      add_venue
    end

    def add_title
      title = ShowViews::TitleView.new
      title.event = @event
      rmq.append(title, :title_container)
    end

    def add_map
      map = ShowViews::MapView.new
      map.event = @event
      rmq.append(map, :map_container)
    end

    def add_actions
      alerts = ShowViews::AlertsView.new
      alerts.event = @event
      rmq.append(alerts, :alerts_container).on(:tap) do |sender, event|
        alert = Alerts::Edit.new(event: @event)
        self.navigationController.pushViewController(alert, animated: true)
      end


      series = ShowViews::SeriesView.new
      series.event = @event
      rmq.append(series, :series_container).on(:tap) do |sender, event|
        puts "series tapped"
      end
    end

    def add_description
      rmq.append(UILabel).data(@event.event_description).apply_style(:event_description)
    end

    def add_venue
      rmq.append(UILabel).data(@event.venue_details).apply_style(:event_description)
    end
  end
end
