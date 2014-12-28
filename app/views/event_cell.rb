class EventCell < PM::TableViewCell
  def start_time=(start_time)
    @event_date ||= rmq.append(UILabel, :event_date)
    @event_time ||= rmq.append(UILabel, :event_time)
    @right_chevron ||= rmq.append(UILabel, :right_chevron)
    @event_date.data = humanized_date(start_time)
    @event_time.data = humanized_time(start_time)
  end

  def title=(title)
    @title_view ||= rmq.append(UILabel, :event_title)
    @title_view.data = title
  end

  def humanized_time(time)
    if time
      if time.string_with_format('mm') == '0'
        time.string_with_format('hh')
      else
        time.string_with_format('h:mm')
      end
    end
  end

  def humanized_date(time)
    if time.same_day?(NSDate.new)
      prefix = "TODAY"
    elsif time.same_day?(1.days.hence)
      prefix = "TOMORROW"
    else
      prefix = time.string_with_format('EEEE')
    end
    "#{prefix} #{time.string_with_style(NSDateFormatterShortStyle)}"
  end



end
