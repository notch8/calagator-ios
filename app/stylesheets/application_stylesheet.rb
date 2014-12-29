class ApplicationStylesheet < RubyMotionQuery::Stylesheet

  def application_setup

    # Change the default grid if desired
    #   rmq.app.grid.tap do |g|
    #     g.num_columns =  12
    #     g.column_gutter = 10
    #     g.num_rows = 18
    #     g.row_gutter = 10
    #     g.content_left_margin = 10
    #     g.content_top_margin = 74
    #     g.content_right_margin = 10
    #     g.content_bottom_margin = 10
    #   end

    # An example of setting standard fonts and colors
    font_family = 'Helvetica Neue'
    font.add_named :large,    font_family, 36
    font.add_named :medium,   font_family, 24
    font.add_named :small,    font_family, 18
    font.add_named :tiny,     font_family, 14

    color.add_named :white, 'ffffff'
    color.add_named :tint, '236EB7'
    color.add_named :translucent_black, color.from_rgba(0, 0, 0, 0.4)
    color.add_named :battleship_gray,   '#445544'
    color.add_named :background_gray,   '#EFEFF4'
    color.add_named :light_gray,   '#c3c3c3'
    color.add_named :dark_gray,  '#82C555'
    color.add_named :light_green, '#8DC555'
    color.add_named :baby_blue, '#E8FBFE'

    UINavigationBar.appearance.setBarTintColor(color.light_green)
    UINavigationBar.appearance.setTintColor(color.white)
    UINavigationBar.appearance.setTitleTextAttributes(NSForegroundColorAttributeName => color.white)

  end

  def root_view(st)
    st.background_color = color.white
  end

  def navigation_icon(st)
    st.color = color.white
  end

  def standard_button(st)
    st.frame = {w: 40, h: 18}
    st.background_color = color.tint
    st.color = color.white
  end

  def standard_label(st)
    st.frame = {w: 40, h: 18}
    st.background_color = color.clear
    st.color = color.black
  end

  def right_chevron(st)
    st.frame = {top: 25, left: app_width - 20, width: 20, height: 20}
    st.color = color.light_gray
    st.font = FontAwesome.fontWithSize(18.0)
    st.view.text = FontAwesome.icon('chevron-right')
  end

end
