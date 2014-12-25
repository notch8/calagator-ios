class EventsScreen < ProMotion::TableScreen
  include Navigation
  refreshable
  searchable

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

  def load_async
    Event.async_load do |events|
      @events = events
      stop_refreshing
      update_table_data
    end
  end
end
