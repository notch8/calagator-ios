module Events
  class ShowLayout < MK::Layout
    def layout
      add UIScrollView, :scroll_view do
        background_color rmq.color.background_gray
        target.scrollEnabled = true

        add UIView, :content_view do
          add UIView, :title do
            background_color rmq.color.white

            add UILabel, :event_title do 
              color rmq.color.battleship_gray
              font rmq.font.small
              target.numberOfLines = 0
              size_to_fit
            end

            add UILabel, :title_line do
              background_color rmq.color.background_gray
            end

            add UILabel, :event_date do 
              color rmq.color.battleship_gray
              font rmq.font.tiny
            end

            add UILabel, :event_time do
              color rmq.color.battleship_gray
              font rmq.font.tiny
            end

            add UILabel, :event_location do
              color rmq.color.battleship_gray
              font rmq.font.tiny
            end
          end

          add MKMapView, :venue_map

          add UIView, :actions_container do
            background_color rmq.color.white

            add UIView, :alert_container do
              add UILabel, :alert_label do
                color rmq.color.battleship_gray
                text "Alerts"
              end

              add UILabel, :alert_settings do
                color rmq.color.light_gray
                text_alignment NSTextAlignmentRight
                font rmq.font.tiny
              end

              add UILabel, :alert_right_chevron do
                color rmq.color.light_gray
                font  FontAwesome.fontWithSize(18.0)
                text  FontAwesome.icon('chevron-right')
              end
            end

            add UILabel, :actions_line do
              background_color rmq.color.background_gray
            end

            add UIView, :series_container do
              add UILabel, :series_label do
                color rmq.color.battleship_gray
                text "Series"
              end

              add UILabel, :series_settings do
                color rmq.color.light_gray
                text "Placeholder"
                text_alignment NSTextAlignmentRight
                font rmq.font.tiny
              end

              add UILabel, :series_right_chevron do
                color rmq.color.light_gray
                font  FontAwesome.fontWithSize(18.0)
                text  FontAwesome.icon('chevron-right')
              end
            end
          end

          add UILabel, :event_description do
            color rmq.color.battleship_gray
            target.numberOfLines = 0
            size_to_fit
            text "dsffafdasdfasfsadfsafsafa"
          end

          add UILabel, :venue do
            color rmq.color.battleship_gray
            target.numberOfLines = 0
            size_to_fit
          end
        end
      end
    end

    def add_constraints
      constraints(:scroll_view) do
        top_left x:0, y: 0
        leading 0
        trailing 0
        width.equals(:superview)
        height.equals(:superview)
      end

      constraints(:content_view) do
        top 0
        bottom 0
        leading 0
        trailing 0
        width.equals(:superview)
      end

      constraints(:title) do
        top_left x: 0, y: 40
        height 120
        width.equals(view)
      end

      constraints(:event_title) do
        top_left x: 20, y: 10
        width.equals(view).minus(40)
      end

      constraints(:title_line) do
        top.equals(:event_title, NSLayoutAttributeBottom).plus(10)
        left 20
        #left.equals(:event_title)
        height 2
        width.equals(view).minus(20)
      end

      constraints(:event_date) do
        top.equals(:title_line, NSLayoutAttributeBottom).plus(6) 
        left.equals(:event_title)
        height 20
        width.equals(view).minus(40)
      end

      constraints(:event_time) do
        top.equals(:event_date, NSLayoutAttributeBottom)
        left.equals(:event_title)
        height 20
        width.equals(view).minus(40)
      end

      constraints(:event_location) do
        top.equals(:event_time, NSLayoutAttributeBottom)
        left.equals(:event_title)
        height 20
        width.equals(view).minus(40)
      end

      constraints(:venue_map) do
        top.equals(:title, NSLayoutAttributeBottom)
        width.equals(view)
        height 120
      end

      constraints(:actions_container) do
        top.equals(:venue_map, NSLayoutAttributeBottom).plus(30)
        left 0
        height 82
        width.equals(view)
      end

      constraints(:alert_container) do
        top_left x: 20, y: 10
        height 20
        width.equals(view).minus(20)
      end

      constraints(:alert_label) do
        top_left x: 0, y:0
        height 20
        width 60
      end

      constraints(:alert_settings) do
        top 0
        left.equals(:alert_right_chevron, NSLayoutAttributeLeft).minus(200)
        height 20
        width 180
      end

      constraints(:alert_right_chevron) do
        top 4
        left.equals(view, NSLayoutAttributeRight).minus(20)
        height 20
        width 20
      end

      constraints(:actions_line) do
        top.equals(:alert_container, NSLayoutAttributeBottom).plus(10)
        left 20
        height 2
        width.equals(view).minus(20)
      end

      constraints(:series_container) do
        top.equals(:actions_line, NSLayoutAttributeBottom).plus(10)
        left.equals(:alert_container)
        width.equals(:alert_container)
        height.equals(:alert_container)
      end

      constraints(:series_label) do
        top_left x: 0, y: 0
        height.equals(:alert_label)
        width.equals(:alert_label)
      end

      constraints(:series_settings) do
        top 0
        left.equals(:series_right_chevron, NSLayoutAttributeLeft).minus(200)
        height 20
        width 180
      end

      constraints(:series_right_chevron) do
        top 4
        left.equals(:alert_right_chevron)
        height.equals(:alert_right_chevron)
        width.equals(:alert_right_chevron)
      end

      constraints(:event_description) do
        top.equals(:series_container, NSLayoutAttributeBottom).plus(30)
        left 20
        width.equals(:superview).minus(40)
      end

      constraints(:venue) do
        top.equals(:event_description, NSLayoutAttributeBottom).plus(20)
        left 20
        width.equals(:event_description)
        bottom 0
      end
    end
  end
end
