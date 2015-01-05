module Events
  class Index < ProMotion::TableScreen
    include Navigation
    refreshable
    searchable

    title 'Calagator'

    def on_load
      rmq.stylesheet = Events::IndexStylesheet
      add_side_menu
      @events ||= []
      load_async
    end

    def on_refresh
      Event.async_load do |events|
        handle_events events
      end
    end

    def load_async
      Event.load_if_stale do |events|
        handle_events events
      end
    end

    def handle_events events
      @events = events
      stop_refreshing
      update_table_data
    end


    def table_data
      [{
        cells: @events.map do |event|
          {
            cell_class: EventCell,
            properties: {
              title: event.title,
              start_time: event.start_time,
            },
            search_text: event.title,
            height: 70,
            action: :view_event,
            arguments: { event: event }
          }
        end
      }]
    end

    def view_event args
      screen = Events::Show.new(nav_bar: true)
      screen.event = args[:event]
      self.navigationController.pushViewController(screen, animated: true)
    end

  end
end
