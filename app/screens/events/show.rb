module Events
  class Show < ProMotion::TableScreen
    include TimeHelpers
    title 'Event'

    attr_accessor :event

    def on_load
      rmq.stylesheet = Events::ShowStylesheet
      NSNotificationCenter.defaultCenter.tap do |dc|
        dc.addObserver(self, selector:'dataDidChange:',
                        name:'MotionModelDataDidChangeNotification',
                        object:nil)
      end
    end

    def table_data
      [{
        title: '',
        title_view_height: 50,
        title_view: ShowViews::AboutHeader,
        cells: [
          {
            cell_class: ShowViews::Title,
            height: 45,
            properties: {
              title: event.title
            }
          },
          {
            cell_class: ShowViews::Detail,
            height: 50,
            properties:{
              event: event
            }
          },
          {
            cell_class: ShowViews::MapSection,
            height: 200,
            properties: {
              event: event
            }
          }
        ]
      },
      {
        title: '',
        title_view_height: 50,
        title_view: ShowViews::Spacer,
        cells: [
          {
            cell_class: ShowViews::ReminderSummary,
            height: 50,
            action: :view_alerts,
            arguments: { event: event },
            properties: {
              event: event
            },
          },
          {
            cell_class: ShowViews::SeriesSummary,
            height: 50,
            action: :view_series,
            arguments: { event: event },
            properties: {
              event: event
            }
          }
        ]
      }]
    end

    def view_alerts args
      screen = Alerts::Edit.new(event: @event, nav_bar: true)
      self.navigationController.pushViewController(screen, animated: true)
    end

    def view_series args
      puts "view series"
    end

    def dataDidChange notification
      self.view.reloadData
    end


      #location_container.append(UILabel).data(@event.venue_title).apply_style(:venue_title)
      #if @event.venue_address
      #  location_container.append(UILabel).data(@event.venue_address).apply_style(:venue_address)
      #end

      #if @event.venue_details
      #  location_container.append(UILabel).data(@event.venue_details).apply_style(:venue_details)
      #end

      #rmq.append(UILabel, :event_description).data(@event.event_description)


    #end

  end
end
