describe 'Event' do
  extend WebStub::SpecHelpers

  before do
    Event.delete_all
    disable_network_access!
    @stubbed_request = stub_request(:get, Event::CALAGATOR_URL).
      to_return(json: '[{"created_at":"2014-12-18T16:11:01-08:00","description":"event description","duplicate_of_id":null,"end_time":"2014-12-30T17:00:00-08:00","id":1250467520,"rrule":null,"source_id":null,"start_time":"2016-12-30T14:00:00-08:00","title":"Introduction to Programming","updated_at":"2014-12-18T16:11:01-08:00","url":"http://learnhowtoprogram.com","venue_details":"","venue_id":202394035,"version":null,"venue":{"access_notes":"","address":"208 SW 5th Ave, Portland, OR 97204","closed":false,"country":"US","created_at":"2013-09-06T08:08:08-07:00","description":"Epicodus is a four month, forty hour per week, in-person class on programming.\r\n\r\nOur space is available usually at no charge evenings and weekends for meet ups, speakers and events. Contact us to see if the schedule is open!","duplicate_of_id":null,"email":"hi@epicodus.com","events_count":26,"id":202394035,"latitude":"45.5218383","locality":"Portland","longitude":"-122.6756462","postal_code":"97204","region":"Oregon","source_id":null,"street_address":"208 SW 5th Ave","telephone":"","title":"Epicodus","updated_at":"2014-04-16T09:21:10-07:00","url":"http://www.epicodus.com/","wifi":false}}]')
  end

  after do
    enable_network_access!
    reset_stubs
  end

  it "should load events" do
    Event.async_load do |result|
      resume
    end
      
    wait_max 1.0 do
      Event.all.length.should == 1
    end

  end

  it "should update event" do
    Event.async_load do |result|
      resume
    end

    wait_max 1.0 do

      before_update = Event.first
   
      Event.async_load do |result|
        resume
      end

      wait_max 1.0 do
        Event.first.should == before_update
      end
    end
  end

  describe "with 50 Events already existing" do
    before do
      50.times do 
        Event.factory
      end
    end

    it "should truncate list to 50 nearest events" do
      Event.async_load do |result|
        resume
      end

      wait_max 1.0 do
        Event.count.should == 50
      end
    end
  end

  describe "with a past event" do
    before do
      Event.factory(start_time: 2.days.ago)
    end

    it "should truncate any events that have already happened" do
      Event.async_load do |result|
        resume
      end

      wait_max 1.0 do
        Event.count.should == 1
        Event.last.event_description.should == "event description"
      end
    end
  end

  #it "should not load events if current" do
  #  Event.last_load = Time.now - 59.minutes
  #  Event.load_if_stale

  #  puts "out of block"

  #  #wait_max 1.0 do
  #    puts "in wait max"
  #    true.should == true
  #    #@stubbed_request.should.not.be.requested
  #  #end
  #end

  #it "should load events if not current" do
  #  Event.last_load = Time.now - 1.hour
  #  Event.load_if_stale do |result|
  #    resume
  #  end

  #  wait_max 1.0 do
  #    @stubbed_request.should.be.requested
  #  end
  #end
end
