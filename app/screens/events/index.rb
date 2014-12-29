module Events
  class Index < ProMotion::TableScreen
    include Navigation
    refreshable
    searchable

    title 'Calagator'

    def on_load
      rmq.stylesheet = Events::IndexStylesheet
      add_side_menu
      @events = []
      load_async
    end

    def on_refresh
      load_async
    end

    def table_data
      [{
        cells: @events.map do |event|
          {
            cell_class: EventCell,
            properties: {
              title: event.title,
              start_time: event.start_time
            },
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

    def load_async
      Event.load_if_stale do |events|
        @events = events
        stop_refreshing
        update_table_data
      end
    end
  end
end
