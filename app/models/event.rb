class Event
  CALAGATOR_URL = 'http://calagator.org/events.json'
  STALE_AFTER = 59.minutes
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include MotionModel::Validatable


  columns :id => :integer,
    source_id: :integer,
    event_description: :string,
    start_time: :date,
    end_time: :date,
    title: :string,
    url: :string,
    venue_id: :integer,
    venue_title: :string,
    venue_access_notes: :string,
    venue_address: :string,
    venue_details: :string,
    venue_latitude: :string,
    venue_longitude: :string,
    venue_url: :string

  has_many :alerts

  #validate :start_time, presence: true

  class << self
    attr_accessor :last_load
    def load_if_stale &block
      if !last_load || (Time.now - STALE_AFTER > last_load) 
        async_load &block
      else
        block.call(self.all) if block
      end
    end

    def async_load &block
      AFMotion::JSON.get(CALAGATOR_URL) do |result|
        if result.success?
          handle_results(result.object)
          finish_event_load(result.object)
        end

        block.call(self.all) if block
      end
    end

    def handle_results(loaded_events)
      loaded_events.each do |result|
        begin
          if found_event = self.where(:id).eq(result['id']).first
            found_event.update_attributes(event_attrs_hash(result))
          else
            self.create(event_attrs_hash(result))
          end
        rescue
          puts "FAIL:"
          puts result
        end
      end
    end

    def event_attrs_hash result
      date_formatter = NSDateFormatter.alloc.init
      date_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"

      attr_hash = {
        id: result['id'],
        source_id: result['source_id'],
        event_description: result['description'],
        start_time: date_formatter.dateFromString(result['start_time']),
        end_time: result['start_time'],
        title: result['title'],
        url: result['url']
      }

      if result['end_time']
        attr_hash.merge!({
          end_time: date_formatter.dateFromString(result['end_time'])
        })
      end

      if result['venue_id']
        attr_hash.merge!({
          venue_id: result['venue']['id'],
          venue_title: result['venue']['title'],
          venue_details: result['venue_details'],
          venue_address: result['venue']['address'],
          venue_latitude: result['venue']['latitude'],
          venue_longitude: result['venue']['longitude'],
          venue_url: result['venue']['url']
        })
      end
      attr_hash
    end

    def finish_event_load result
      clear_removed_events(result)
      self.last_load = Time.now
      self.serialize_to_file('events.dat')
    end

    def clear_removed_events(loaded_events)
      ids = loaded_events.collect{|o| o["id"]}
      to_remove = Event.all.collect do |event|
        if ids.index(event.id).nil?
          event
        end
      end
      to_remove.compact.each{ |e| e.destroy }
    end

    def factory attrs = {}
      self.create!({id: Time.now.usec, start_time: 2.days.hence, end_time: 2.days.hence + 2.hours}.merge(attrs))
    end
  end
end
