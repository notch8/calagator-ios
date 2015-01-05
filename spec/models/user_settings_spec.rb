describe UserSettings do
  before do
    App::Persistence['user_settings'] = nil
    @settings = UserSettings.new
  end

  it "should set base url to calagator.org if not set" do
    @settings.base_url.should == 'http://calagator.org/events.json'
  end

  it "should set morning options" do
    @settings.morning_options["7 AM"].should == 7 
    @settings.morning_options["8 AM"].should == 8
    @settings.morning_options["9 AM"].should == 9 
    @settings.morning_options["10 AM"].should == 10 
  end

  it "should set beforehand options" do
    @settings.beforehand_options['10 minutes'].should == 10
    @settings.beforehand_options['20 minutes'].should == 20
    @settings.beforehand_options['40 minutes'].should == 40
    @settings.beforehand_options['1 hour'].should == 60
  end

  it "should set morning alert time" do
    @settings.morning_alert_time.should == 8
  end

  it "should set beforehand_alert_time" do
    @settings.beforehand_alert_time.should == 20
  end
end
