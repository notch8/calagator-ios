module Events
  module ShowViews
    class AboutHeader < UIView
      def didMoveToWindow
        rmq.stylesheet = Events::ShowStylesheet
        rmq(self).apply_style(:about_header)
      end
    end
  end
end

