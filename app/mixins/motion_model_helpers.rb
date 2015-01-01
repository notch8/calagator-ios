module MotionModelHelpers
  def setup_notifications
    NSNotificationCenter.defaultCenter.tap do |dc|
      dc.addObserver(self, selector:'dataDidChange:',
                      name:'MotionModelDataDidChangeNotification',
                      object:nil)
    end
  end

  def dataDidChange
    raise "Notifications are setup, but dataDidChange is not implimented"
  end
end
