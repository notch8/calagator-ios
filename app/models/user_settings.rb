class UserSettings
  attr_accessor :morning_options, :beforehand_options, :morning_alert_time, :beforehand_alert_time, :base_url
  def initialize
    App::Persistence['alert_settings'] ||= {:morning_alert_time=>8, :beforehand_alert_time=>20}
    self.morning_alert_time = App::Persistence['alert_settings'][:morning_alert_time]
    self.beforehand_alert_time = App::Persistence['alert_settings'][:beforehand_alert_time]

    self.morning_options = { "7 AM" => 7, "8 AM" => 8, "9 AM" => 9, "10 AM" => 10 }
    self.beforehand_options = { "10 minutes" => 10, "20 minutes" => 20, "40 minutes" => 40, "1 hour" => 60 }

    App::Persistence['user_settings'] ||= {base_url: 'http://calagator.org/events.json'}
    self.base_url = App::Persistence['user_settings'][:base_url]
  end


  def update_settings settings_hash
    App::Persistence['alert_settings'] = settings_hash
  end
end
