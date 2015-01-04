module Alerts
  class Index < ProMotion::TableScreen
    include Navigation

    title 'My Events'

    def on_load
      add_side_menu
    end

    def table_data
      [{
        title: nil,
        cells: events.map do |event|
          {
            title: event.title,
            action: :alert_choosen,
            arguments: { event: event }
          }
        end
      }]
    end

    def alert_choosen args
      screen = Events::Show.new(nav_bar: true)
      screen.event = args[:event]
      self.navigationController.pushViewController(screen, animated: true)
    end

    def events
      all = Alert.all.collect(&:event)
      all.uniq
    end
  end
end
