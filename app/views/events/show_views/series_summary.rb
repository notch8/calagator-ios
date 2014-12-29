module Events
  module ShowViews
    class SeriesSummary < PM::TableViewCell
      def event=(event)
        @right_chevron ||= rmq.append(UILabel, :right_chevron)
        @series_label ||= rmq.append(UILabel, :label).data("Series")
      end
    end
  end
end

