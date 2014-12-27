module Events
  class Show < PM::Screen
    include Navigation
    title 'Calendar'

    attr_accessor :event

    def on_load
      rmq.stylesheet = Events::ShowStylesheet
      rmq(self.view).apply_style :root_view

      rmq.append(UITextView, :event_title).data(@event.title)
      rmq.append(UITextView, :date_and_time).data(humanized_date_and_time)
      rmq.append(UITextView, :event_description).data(@event.event_description)
    end

    def will_appear
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
          time.string_with_format('HH')
        else
          time.string_with_format('h:mm')
        end
      else
        '???'
      end
    end
  end
end
