module Events
  module ShowViews
    class Spacer < UIView
      def didMoveToWindow
        rmq.stylesheet = Events::ShowStylesheet
        rmq(self).apply_style(:event_spacer)
      end
    end
  end
end

