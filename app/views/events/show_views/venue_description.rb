module Events
  module ShowViews
    class VenueDescription < PM::TableViewCell
      def event= event
        rmq(self).apply_style(:description_container)
      end
    end
  end
end
