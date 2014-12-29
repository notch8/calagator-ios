module Events
  class IndexStylesheet < ApplicationStylesheet
    def event_date(st)
      st.frame = {top: 5, left: 20, width: 200, height: 15}
      st.color = color.light_gray
      st.font = font.tiny
    end

    def event_title(st)
      st.frame = {top: 20, left: 20, width: app_width - 100, height: 36}
      st.color = color.battleship_gray
      st.font = font.small
      st.view.lineBreakMode = 0
      st.view.numberOfLines = 0
    end

    def event_time(st)
      st.frame = {top: 5, left: app_width - 80, width: 60, height: 20}
      st.color = color.light_gray
      st.font = font.tiny
    end

  end
end
