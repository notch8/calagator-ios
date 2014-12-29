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
            height: cell_height_for(event.title, rmq.font.medium),
            properties: {
              title: event.title
            }
          },
          {
            cell_class: ShowViews::Detail,
            height: 70,
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
            height: 30,
            action: :view_alerts,
            arguments: { event: event },
            properties: {
              event: event
            },
          },
          {
            cell_class: ShowViews::SeriesSummary,
            height: 40,
            action: :view_series,
            arguments: { event: event },
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
        cells:[
          {
            cell_class: ShowViews::Description,
            properties: { event: event },
            height: cell_height_for(event.event_description)
          },
        ]
      },
      {
        title: "About: #{event.venue_title}",
        title_view_height: 30,
        cells:[
          {
            cell_class: ShowViews::VenueDescription,
            properties: { event: event },
            height: cell_height_for(event.venue_details)
          }
        ]
      }]
    end

    def cell_height_for(text, font=nil)
      puts "\n\n\nin chf"
      font ||= rmq.font.small
      if text
        constraintSize = [rmq.device.width - 40, 9999]
        label_size = text.sizeWithFont(font, constrainedToSize: constraintSize, lineBreakMode: UILineBreakModeWordWrap)
        puts "height: #{label_size.height}, text:"
        puts text
        label_size.height + 10
      else
        0
      end
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
  end
end
