module Alerts
  class Edit < PM::FormotionScreen 
    include BubbleWrap::KVO
    attr_accessor :event

    title 'Alerts'

    def on_load
      rmq.stylesheet = Alerts::EditStylesheet
      observe_form
    end

    def table_data
      {
        sections: [{
          rows: [
            {
              title: 'Morning',
              subtitle: "Remind me in the morning",
              key: :morning,
              type: :switch,
              value: @event.alerts.where(:alert_type).eq('morning').length != 0,
            },
            {
              title: 'Beforehand',
              subtitle: "Remind me before it starts",
              value: @event.alerts.where(:alert_type).eq('beforehand').length != 0,
              key: :beforehand,
              type: :switch
            },
            {
              title: 'Starting',
              subtitle: "Remind me when it starts",
              value: @event.alerts.where(:alert_type).eq('starting').length != 0,
              key: :starting,
              type: :switch
            }
          ]
        }]
      }
    end


    def observe_form
      self.form.sections[0].rows.each do |row|
        observe(row, "value") do |old_value, new_value|
          update_alerts self.form.render
        end
      end
    end

    def update_alerts settings
      settings.each do |name, enabled|
        alert = @event.alerts.where(:alert_type).eq(name.to_s).first
        if enabled && !alert
          a = @event.alerts.create(alert_type: name.to_s)
        elsif !enabled && alert
          alert.destroy
        end
      end
      Alert.persist
    end
  end
end
