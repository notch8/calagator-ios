module Events
  class Index < ProMotion::TableScreen
    include Navigation
    refreshable
    searchable

    title 'Calendar'

    def on_load
      add_side_menu
      @events = []
      load_async
    end

    def table_data
      [{
        cells: @events.map do |event|
          {
            title: event.title,
            subtitle: event.event_description,
            action: :view_event,
            arguments: { event: event }
          }
        end
      }]
    end

    def view_event args
      puts args
      controller = Events::Show.new(nav_bar: true)
      controller.event = args[:event]
      app_delegate.menu.center_controller = controller

    end

    def load_async
      Event.async_load do |events|
        @events = events
        stop_refreshing
        update_table_data
      end
    end
  end
end
