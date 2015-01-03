module Navigation
  def add_side_menu
    label = UILabel.alloc.initWithFrame([[0, 0],[20, 20]])
    label.font = FontAwesome.fontWithSize(16.0)
    label.text = FontAwesome.icon('list')
    label.color = rmq.color.white

    set_nav_bar_button :left, {custom_view: label, action: :tapped_left_nav}

    rmq(label).on(:tap) do |sender|
      app_delegate.menu.show(:left)
    end
  end

  def tapped_left_nav
    app_delegate.show_menu
  end
end
