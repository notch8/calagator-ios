module Events
  class Show < ProMotion::Screen
    include TimeHelpers
    title 'Event'

    attr_accessor :event

    def on_load
      @layout = Events::ShowLayout.new
      self.view = @layout.view
      @layout.add_constraints
      #self.view = UIScrollView.alloc.initWithFrame(self.view.bounds)
      #self.edgesForExtendedLayout = UIRectEdgeNone
      #rmq.stylesheet = Events::ShowStylesheet
      #rmq(self.view).apply_style(:root_scroll_view)

      #self.view.contentSize = [rmq.device.width, calculated_height]
      #self.view.scrollEnabled = true
    end

    def start_end_time
      "from #{humanized_time(@event.start_time)} to #{humanized_time(@event.end_time)}"
    end

    #def calculated_height
    #  description_height = rmq(:event_description).get.frame.size.height 
    #  venue_height = rmq(:venue_description).get.frame.size.height
    #  other_views_height = 600
    #  other_views_height + description_height + venue_height
    #end


  end
end
