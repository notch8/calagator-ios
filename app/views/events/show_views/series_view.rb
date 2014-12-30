module Events
  module ShowViews
    class SeriesView < UIView
      include MotionModelHelpers
      attr_accessor :event

      def rmq_build
        rmq.stylesheet = Events::ShowStylesheet
        rmq(self).apply_style(:series_container)
        container = rmq(self)

        container.append(UILabel, :label).data("Series")
        container.append(UILabel, :right_chevron).nudge(u: 14)
      end
    end
  end
end

