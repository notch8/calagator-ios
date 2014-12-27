class NavigationControllerStylesheet < ApplicationStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def table(st)
    st.background_color = color.gray
  end

  def navigation_cell_height
    50
  end

  def navigation_cell(st)
  end

  def cell_label(st)
    st.color = color.white
  end
end
