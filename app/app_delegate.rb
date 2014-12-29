class MenuDrawer < PM::Menu::Drawer
  def setup
    self.center = Events::Index.new(nav_bar: true)
    self.left = NavigationScreen
    self.to_show = [:all]
    self.max_left_width = 250
    self.shadow = false
  end
end

class AppDelegate < PM::Delegate
  attr_reader :events
  #attr_reader :window
  status_bar true, animation: :fade

  def on_load(app, options)
    @menu = open MenuDrawer
    @events = Event.deserialize_from_file('events.dat')
    @alerts = Alert.deserialize_from_file('alertss.dat')
  end

  def show_menu
    @menu.show :left
  end
  

  #def application(application, didFinishLaunchingWithOptions:launchOptions)
  #  @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

  #  main_controller = MainController.new
  #  @window.rootViewController = UINavigationController.alloc.initWithRootViewController(main_controller)

  #  @window.makeKeyAndVisible
  #  true
  #end

  ## Remove this if you are only supporting portrait
  #def application(application, willChangeStatusBarOrientation: new_orientation, duration: duration)
  #  # Manually set RMQ's orientation before the device is actually oriented
  #  # So that we can do stuff like style views before the rotation begins
  #  rmq.device.orientation = new_orientation
  #end
end
