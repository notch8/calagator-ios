class NavigationScreen < ProMotion::TableScreen
  def on_load
    rmq.stylesheet = NavigationControllerStylesheet
    rmq(self.view).apply_style(:table)
  end

  def tapped_right_nav
    app_delegate.menu.hide
  end

  def table_data
    [{
      title: nil,
      cells: [
        { 
          title: ''
        },
        {
          title: 'Calendar',
          action: :swap_center_controller,
          arguments: Events::Index
        },
        {
          title: 'My Events',
          action: :swap_center_controller,
          arguments: Alerts::Index
        },
        {
          title: 'Settings',
          action: :swap_center_controller,
          arguments: SettingsScreen
        },
        {
          title: 'About',
          action: :swap_center_controller,
          arguments: AboutScreen
        }
      ]
    }]
  end

  def swap_center_controller(screen_class)
    app_delegate.menu.center_controller = screen_class.new(nav_bar: true)
    app_delegate.menu.hide
  end
end
