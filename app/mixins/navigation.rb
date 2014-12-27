module Navigation
  def add_side_menu
    label = UILabel.alloc.initWithFrame([[0, 0],[20, 20]])
    label.font = FontAwesome.fontWithSize(16.0)
    label.text = FontAwesome.icon('list')
    rmq(label).apply_style(:navigation_icon)

    set_nav_bar_button :left, {custom_view: label, action: :tapped_left_nav}
  end

  def tapped_left_nav
    puts "tapped"
    app_delegate.show_menu
  end
end
