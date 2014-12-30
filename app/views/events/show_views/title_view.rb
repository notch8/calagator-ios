module Events
  module ShowViews
    class TitleView < UIView
      include TimeHelpers
      attr_accessor :event

      def rmq_build
        rmq.stylesheet = Events::ShowStylesheet
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
  end
end
