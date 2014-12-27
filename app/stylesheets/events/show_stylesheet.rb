module Events
  class ShowStylesheet < ApplicationStylesheet
    def setup
    end

    def event_title(st)
      st.frame = {top: 100, width: app_width - 20, height: 20, centered: :horizontal}
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

    def venue_location(st)
      st.frame = {top: 10, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def venue_address(st)
      st.frame = {top: 30, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def venue_details(st)
      st.frame = {top: 50, width: app_width - 20, height: 20, centered: :horizontal}
      st.color = color.battleship_gray
      st.view.fit_to_size(24)
    end

    def event_description(st)
      st.frame = {top: 500, width: app_width - 20, height: 200, centered: :horizontal}
      st.color = color.battleship_gray
      st.font = font.small
    end

  end
end
