module Events
  module ShowViews
    class ReminderSummary < PM::TableViewCell
      def event=(event)
        @alert_label ||= rmq.append(UILabel, :label).data("Alert")
        @right_cevron ||= rmq.append(UILabel, :right_chevron)

        if event.alerts.length == 0
          text = "No alerts"
        else
          text = event.alerts.all.map{|a| a.alert_type.capitalize}.join(", ")
        end
        @setting_label ||= rmq.append(UILabel, :setting)
        @setting_label.data(text)
      end
    end
  end
end
