module Events
  class ShowStylesheet < ApplicationStylesheet
    def setup
    end

    def event_title(st)
    end

    def event_description(st)
      st.frame = {top: 500, width: app_width - 20, height: 200, centered: :horizontal}
      st.color = color.battleship_gray
      st.font = font.small
    end

    def date_and_time(st)
      st.frame = {top: 100, width: app_width - 20, height: 200, centered: :horizontal}
      st.color = color.battleship_gray
      st.font = font.tiny
    end
  end
end
