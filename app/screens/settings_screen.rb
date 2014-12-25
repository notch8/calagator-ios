class SettingsScreen < PM::Screen
  include Navigation
  title 'Settings'

  def on_load
    rmq.stylesheet = SettingsStylesheet
    rmq(self.view).apply_style :root_view

    add_side_menu
  end
end
