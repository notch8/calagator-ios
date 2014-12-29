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
      st.frame = {top: 10, width: app_width - 40, height: 0, left: 20}
      st.color = color.battleship_gray
      st.view.lineBreakMode = UILineBreakModeWordWrap
      st.view.numberOfLines = 0
      st.view.sizeToFit

    end

    def detail_cell(st)
      st.color = color.battleship_gray
      st.font = font.tiny
    end

    def event_date(st)
      detail_cell st
      st.frame = {top: 5, width: app_width - 20, height: 20, left: 20}
    end

    def event_time(st)
      detail_cell st
      st.frame = {top: st.prev_frame.bottom, width: app_width - 20, height: 20, left: 20}
    end

    def event_location(st)
      detail_cell st
      st.frame = {top: st.prev_frame.bottom, width: app_width - 20, height: 20, left: 20}
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

    def label_base(st)
      st.color = color.battleship_gray
      st.font = font.small
    end

    def label(st)
      label_base(st)
      st.frame = {top: 10, width: 100, height: 20, left: 20}
    end

    def long_label(st)
      label_base(st)
      st.frame = {top: 10, width: app_width - 40, height: 20, left: 20}
    end

    def setting(st)
      st.frame = {
        top: 10, 
        width: 180, 
        height: 20, 
        left: app_width - 200
      }
      st.color = color.light_gray
      st.font = font.tiny
    end

    def description_container(st)
      st.background_color = color.background_gray
    end

    def description_paragraph(st)
      st.view.lineBreakMode = UILineBreakModeWordWrap
      st.view.numberOfLines = 0
      st.view.adjustsFontSizeToFitWidth = true
      st.font = font.small
      st.view.sizeToFit
      st.color = color.battleship_gray
      puts st.frame.h 
    end

    def event_description(st)
      st.frame = {
        top: 0,
        width: app_width - 40, 
        height: 0,
        left: 20
      }

      description_paragraph st
    end

    def venue_description(st)
      st.frame = {
        top: 30,
        width: app_width - 40, 
        height: 0,
        left: 20
      }

      description_paragraph st
    end
  end
end
