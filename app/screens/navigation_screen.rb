class NavigationScreen < ProMotion::TableScreen

  def table_data
    [{
      title: nil,
      cells: [
        {
          title: 'Calendar',
          action: :swap_center_controller,
          arguments: EventsScreen
        },
        {
          title: 'Settings',
          action: :swap_center_controller,
          arguments: SettingsScreen
        }
      ]
    }]
  end

  def swap_center_controller(screen_class)
    app_delegate.menu.center_controller = screen_class.new(nav_bar: true)
    app_delegate.menu.hide
  end
end
