module Events
  class ShowStylesheet < ApplicationStylesheet
    def setup
    end

    def event_spacer(st)
      st.background_color = color.background_gray
    end

    def about_header(st)
      event_spacer(st)
    end

    def event_title(st)
      st.frame = {top: 10, width: app_width - 20, height: 30, left: 20}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def detail_cell(st)
      st.color = color.battleship_gray
      st.font = font.tiny
    end

    def event_date(st)
      detail_cell st
      st.frame = {top: 5, width: app_width - 20, height: 14, left: 20}
    end

    def event_time(st)
      detail_cell st
      st.frame = {top: st.prev_frame.bottom, width: app_width - 20, height: 14, left: 20}
    end

    def event_location(st)
      detail_cell st
      st.frame = {top: st.prev_frame.bottom, width: app_width - 20, height: 14, left: 20}
    end

    def location_container(st)
    end

    def venue_map(st)
      st.frame = {top: 0, width: app_width - 20, height: 120, centered: :horizontal}
      st.view.mapType = MKMapTypeStandard
      st.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
      st.view.zoomEnabled = true
    end

    def venue_address(st)
      st.frame = {top: st.prev_frame.bottom, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def label(st)
      st.frame = {top: 10, width: 100, height: 20, left: 20}
      st.color = color.battleship_gray
      st.font = font.small
    end

    def setting(st)
      st.frame = {top: 10, width: 180, height: 20, left: app_width - 200}
      st.color = color.light_gray
      st.font = font.tiny
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
