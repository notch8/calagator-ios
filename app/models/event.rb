class Event
  CALAGATOR_URL = 'http://calagator.org/events.json'
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :id => :integer,
    source_id: :integer,
    event_description: :string,
    start_time: :string,
    title: :string,
    url: :string,
    venue_id: :integer,
    venue_access_notes: :string,
    venue_address: :string,
    venue_description: :string,
    venue_latitude: :string,
    venue_longitude: :string,
    venue_url: :string

  class << self
    def async_load &block
      AFMotion::JSON.get(CALAGATOR_URL) do |result|
        if result.success?
          handle_results(result)
          finish_event_load
        end

        block.call(self.all)
      end
    end

    def handle_results(result)
      result.object.each do |result|
        begin
          unless self.where(:id).eq(result['id']).first
            create_event(result)
          end
        rescue
          puts "FAIL:"
          puts result
        end
      end
    end

    def create_event result
      attr_hash = {
        id: result['id'],
        source_id: result['source_id'],
        event_description: result['description'],
        start_time: result['start_time'],
        title: result['title'],
        url: result['url']
      }

      if result['venue_id']
        attr_hash.merge!({
          venue_id: result['venue']['id'],
          venue_access_notes: result['venue']['access_notes'],
          venue_address: result['venue']['address'],
          venue_description: result['venue']['description'],
          venue_latitude: result['venue']['latitude'],
          venue_longitude: result['venue']['longitude'],
          venue_url: result['venue']['url']
        })
      end
      self.create(attr_hash)
    end

    def finish_event_load
      self.serialize_to_file('events.dat')
    end
  end
end
