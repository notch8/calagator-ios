class SettingsScreen < PM::FormotionScreen
  include Navigation
  title 'Settings'

  def on_load
    add_side_menu

    self.form.row(:remove_alerts).on_tap do |row|
      puts "tappity"
      UIAlertView.alert('Please Confirm', 'Are you sure you want to remove all your event alerts?',
        buttons: {
          cancel: 'No!',
          success: 'Remove them'
        }) do |button|
          if button == :success
            Alert.destroy_all
          end
        end
    end
  end

  def on_submit(_form)
    @settings.update_settings _form.render
    screen = Events::Index.new
    self.navigationController.pushViewController(screen, animated: true)
  end

  def table_data
    @settings = AlertSettings.new
    {
      sections: [{
        title: "Morning Alerts",
        key: :morning_alert_time,
        select_one: true,
        rows: @settings.morning_options.collect do |title, option|
          {
            value: @settings.morning_alert_time == option,
            title: title,
            key: option,
            type: :check
          }
        end
      },
      {
        title: "Beforehand Alerts",
        key: :beforehand_alert_time,
        select_one: true,
        rows: @settings.beforehand_options.collect do |title, option|
          {
            value: @settings.beforehand_alert_time == option,
            title: title,
            key: option,
            type: :check
          }
        end
      },
      {
        rows: [{
          title: "Remove alerts for all events",
          type: :button,
          key: :remove_alerts
        }]
      },
      {
        rows: [{
          title: "Save",
          type: :submit
        }]
      }]
    }
  end
end
