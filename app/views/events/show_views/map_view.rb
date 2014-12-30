module Events
  module ShowViews
    class MapView < UIView
      attr_accessor :event

      def rmq_build
        rmq.stylesheet = Events::ShowStylesheet
        if @event.venue_longitude && event.venue_latitude
          rmq(self).apply_style(:map_container)
          map = MKMapView.alloc.init

          rmq(self).append(map).apply_style(:venue_map)

          location = CLLocationCoordinate2DMake(@event.venue_latitude, @event.venue_longitude)
          pin = MapAnnotation.alloc.initWithCoordinates(location, title: @event.venue_title, subTitle: @event.venue_address)
          map.addAnnotation(pin)

          region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.1, 0.1)) 
          map.setRegion(region, animated: true)
        end

      end
    end

  end
end
