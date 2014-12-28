module Events
  class ShowStylesheet < ApplicationStylesheet
    def setup
    end

    def event_title(st)
      st.frame = {top: 70, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def date_and_time(st)
      st.frame = {top: 120, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.light_green
      st.font = font.tiny
    end

    def location_container(st)
      st.frame = {top: 150, width: app_width, height: 200, centered: :horizontal}
      st.background_color = color.baby_blue
    end

    def venue_title(st)
      st.frame = {top: 10, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def venue_address(st)
      st.frame = {top: st.prev_frame.bottom, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def venue_details(st)
      st.frame = {top: st.prev_frame.bottom, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def venue_map(st)
      st.frame = {top: st.prev_frame.bottom, width: app_width - 20, height: 120, centered: :horizontal}
      st.view.mapType = MKMapTypeStandard
      st.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
      st.view.zoomEnabled = true
    end

    def event_description(st)
      st.frame = {top: 280, width: app_width - 20, height: 800, centered: :horizontal}
      st.color = color.battleship_gray
      st.font = font.tiny
      st.view.lineBreakMode = 0
      st.view.numberOfLines = 0
    end

  end
end
