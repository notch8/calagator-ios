module Events
  module ShowViews
    class Detail < PM::TableViewCell
      include TimeHelpers
      def event=(event)
        @event_date ||= rmq.append(UILabel, :event_date).data(humanized_date(event.start_time))

        time = "from #{humanized_time(event.start_time)} to #{humanized_time(event.end_time)}"
        @event_time_label ||= rmq.append(UILabel, :event_time)
        @event_time_label.data(time)

        @event_location_label ||= rmq.append(UILabel, :event_location)
        @event_location_label.data(event.venue_title)
      end
    end
  end
end
