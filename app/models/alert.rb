class Alert
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  belongs_to :event

  columns alert_type: :string

  def self.persist
    serialize_to_file('alerts.dat')
  end

  def after_save(sender)
    update_alert
  end

  def after_delete(sender)
    cancel_alert
  end

  def cancel_alert
    UIApplication.sharedApplication.tap do |app|
      notification = app.scheduledLocalNotifications.find do |n|
        if n.userInfo && n.userInfo[:uid]
          n.userInfo[:uid] == notification_id
        end
      end
      app.cancelLocalNotification(notification) if notification
    end
  end

  def update_alert
    has_or_gets_permission
    Takeoff::Reminders.schedule(
      body: "#{self.event.title} is starting.",
      fire_date: alert_date,
      user_info: { uid: notification_id },
      badge_number: 1
    )
  end
  
  private

    def has_or_gets_permission
      unless has_permission?
        Takeoff::Reminders.setup
      end

      has_permission?
    end

    def alert_date
      if self.alert_type == 'morning'
        morning_alert_date
      elsif self.alert_type == 'beforehand'
        beforehand_alert_date
      else
        starting_alert_date
      end
    end

    def morning_alert_date
      self.event.start_time.start_of_day + 7.hours
    end

    def beforehand_alert_date
      self.event.start_time - 20.minutes
    end

    def starting_alert_date
      self.event.start_time
    end

    def has_permission?
      app = UIApplication.sharedApplication
      granted_settings = app.currentUserNotificationSettings
      granted_settings.types == UIUserNotificationTypeAlert
    end

    def notification_id
      "#{self.event.id}_#{self.alert_type}"
    end
end
