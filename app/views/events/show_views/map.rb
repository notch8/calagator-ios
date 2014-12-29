module Events
  module ShowViews
    class MapSection < PM::TableViewCell
      def event= event
        if event.venue_longitude && event.venue_latitude
          @map ||= begin
            rmq(self).apply_style(:location_container)
            map = MKMapView.alloc.init

            rmq(self).append(map).apply_style(:venue_map)

            location = CLLocationCoordinate2DMake(event.venue_latitude, event.venue_longitude)
            pin = MapAnnotation.alloc.initWithCoordinates(location, title: event.venue_title, subTitle: event.venue_address)
            map.addAnnotation(pin)

            region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.1, 0.1)) 
            map.setRegion(region, animated: true)
          end
        end
      end
    end
  end
end
