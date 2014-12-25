class MainScreen < PM::Screen 
  include Navigation
  title "Calendar"

  def on_load
    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view
    add_side_menu
    @hello_world_label = rmq.append!(UILabel, :hello_world)
  end

  def will_appear
    puts "will appear"
  end


  #def supportedInterfaceOrientations
  #  UIInterfaceOrientationMaskAll
  #end

  #def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
  #  # Called before rotation
  #  rmq.all.reapply_styles
  #end

  #def viewWillLayoutSubviews
  #  # Called anytime the frame changes, including rotation, and when the in-call status bar shows or hides
  #  #
  #  # If you need to reapply styles during rotation, do it here instead
  #  # of willAnimateRotationToInterfaceOrientation, however make sure your styles only apply the layout when
  #  # called multiple times
  #end

  #def didRotateFromInterfaceOrientation(from_interface_orientation)
  #  # Called after rotation
  #end
end


__END__

# You don't have to reapply styles to all UIViews, if you want to optimize,
# another way to do it is tag the views you need to restyle in your stylesheet,
# then only reapply the tagged views, like so:
def logo(st)
  st.frame = {t: 10, w: 200, h: 96}
  st.centered = :horizontal
  st.image = image.resource('logo')
  st.tag(:reapply_style)
end

# Then in willAnimateRotationToInterfaceOrientation
rmq(:reapply_style).reapply_styles


