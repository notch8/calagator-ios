module Events
  class Show < PM::Screen
    include Navigation
    title 'Calagator'

    attr_accessor :event

    def on_load
      rmq.stylesheet = Events::ShowStylesheet
      rmq(self.view).apply_style :root_view

      rmq.append(UILabel).data(@event.title).apply_style(:event_title)
      rmq.append(UILabel, :date_and_time).data(humanized_date_and_time)
      location_container = rmq.append(UIView, :location_container)
      location_container.append(UILabel).data(@event.venue_title).apply_style(:venue_location)
      if @event.venue_address
        location_container.append(UILabel).data(@event.venue_address).apply_style(:venue_address)
      end

      if @event.venue_details
        location_container.append(UILabel).data(@event.venue_details).apply_style(:venue_details)
      end

      rmq.append(UITextView, :event_description).data(@event.event_description)
    end

    private
    def humanized_date_and_time
      "#{humanized_date(@event.start_time)} from #{humanized_time(@event.start_time)} - #{humanized_time(@event.end_time)}"
    end

    def humanized_date(time)
      if time
        time.string_with_format('EEEE, MMMM d, YYYY')
      else
        "???"
      end
    end

    def humanized_time(time)
      if time
        if time.string_with_format('mm') == '0'
          time.string_with_format('hh')
        else
          time.string_with_format('h:mm')
        end
      else
        '???'
      end
    end
  end
end
