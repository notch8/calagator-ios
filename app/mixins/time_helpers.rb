module TimeHelpers
  def humanized_date_and_time(time)
    "#{humanized_date(time)} from #{humanized_time(time)} - #{humanized_time(time)}"
  end

  def humanized_date(time)
    if time
      time.string_with_format('EEEE, MMMM d, YYYY')
    else
      "???"
    end
  end

  def humanized_time(time)
    if time
      if time.string_with_format('mm') == '0'
        time.string_with_format('hh')
      else
        time.string_with_format('h:mm')
      end
    else
      '???'
    end
  end
end
