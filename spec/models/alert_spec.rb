describe 'Alert' do
  extend WebStub::SpecHelpers
  before do
    @event = Event.create(title: 'Event', start_time: 1.day.hence)
    Takeoff::Reminders.reset
  end

  after do
    Takeoff::Reminders.reset
  end

  #it "should takoff" do
  #  t = Takeoff::Reminders.schedule(
  #    body: "aaaaa",
  #    fire_date: 5.minutes.hence,
  #    user_info: { uid: 'sdfadfa' },
  #    badge_number: 1
  #  )

  #  UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 1
  #end


  it "should set UINotification" do
    alert = Alert.new(event: @event, alert_type: 'morning')
    alert.update_alert
    UIApplication.sharedApplication.scheduledLocalNotifications
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 1
  end

  it "should set alert tiltle to contain 'is today' if type is 'morning'" do
    alert = Alert.new(event: @event, alert_type: 'morning')
    alert.update_alert
    UIApplication.sharedApplication.scheduledLocalNotifications
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.alertBody.should == 'Event is today.'
  end

 it "should set alert for beginning of day if type is 'morning'" do
    alert = Alert.new(event: @event, alert_type: 'morning')
    alert.update_alert
    UIApplication.sharedApplication.scheduledLocalNotifications
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.fireDate.string_with_style.should == 1.day.hence.start_of_day.string_with_style
  end

  it "should set alert for beginning of day + settings offset if type is 'morning'" do
    settings = UserSettings.new
    settings.morning_alert_time = 30

    alert = Alert.new(event: @event, alert_type: 'morning')
    alert.update_alert
    UIApplication.sharedApplication.scheduledLocalNotifications
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first

    target_alert_time = 1.day.hence.start_of_day + settings.morning_alert_time.minutes
    notification.fireDate.string_with_style.should == target_alert_time.string_with_style
  end



  it "should set alert tiltle to contain 'will begin shortly.' if type is 'beforehand'" do
    alert = Alert.new(event: @event, alert_type: 'beforehand')
    alert.update_alert

    UIApplication.sharedApplication.scheduledLocalNotifications
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.alertBody.should == 'Event will begin shortly.'
  end

 it "should set alert for beforehand if type is 'morning'" do
    settings = UserSettings.new
    target_alert_time = @event.start_time - settings.beforehand_alert_time.minutes
    alert = Alert.new(event: @event, alert_type: 'beforehand')
    alert.update_alert
    UIApplication.sharedApplication.scheduledLocalNotifications
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.fireDate.string_with_style.should == target_alert_time.string_with_style
  end


  it "should set alert tiltle to contain 'is starting.' if type is 'start'" do
    alert = Alert.new(event: @event, alert_type: 'start')
    alert.update_alert
    UIApplication.sharedApplication.scheduledLocalNotifications
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.alertBody.should == 'Event is starting.'
  end

 it "should set alert for start_time if type is 'start'" do
    settings = UserSettings.new
    alert = Alert.new(event: @event, alert_type: 'start')
    alert.update_alert
    UIApplication.sharedApplication.scheduledLocalNotifications
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.fireDate.string_with_style.should == @event.start_time.string_with_style
  end





end
