module Events
  module ShowViews
    class AlertsView < UIView
      include MotionModelHelpers
      attr_accessor :event
      def rmq_build
        rmq.stylesheet = Events::ShowStylesheet
        rmq(self).apply_style(:alerts_container)
        container = rmq(self)
        container.append(UILabel, :label).data("Alert")
        container.append(UILabel, :right_chevron).nudge(u: 14)
        container.append(UILabel, :line).nudge(d: 8)

        set_content
        setup_notifications

      end

      def set_content
        if @event.alerts.length == 0
          text = "No alerts"
        else
          text = @event.alerts.all.map{|a| a.alert_type.capitalize}.join(", ")
        end
        rmq(:setting).data(text)
      end

      def dataDidChange notification
        @event = Event.where(:id).eq(@event.id).first
        set_content
      end

    end
  end
end


