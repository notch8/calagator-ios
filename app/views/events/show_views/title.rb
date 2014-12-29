module Events
  module ShowViews
    class Title < PM::TableViewCell
      def title=(title)
        rmq.append(UILabel).data(title).apply_style(:event_title)
      end
    end
  end
end
