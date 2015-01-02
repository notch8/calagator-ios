class AboutScreen < ProMotion::Screen
  include Navigation

  def on_load
    add_side_menu
    @layout = AboutLayout.new
    self.view = @layout.view
    @layout.add_constraints

    setup_links
  end

  def setup_links
    rmq(@layout.get(:calagator_url)).on(:tap) do |sender|
      url = NSURL.URLWithString('http://www.calagator.org')
      App.open_url url
    end

    rmq(@layout.get(:notch8_url)).on(:tap) do |sender|
      url = NSURL.URLWithString('http://www.notch8.com')
      App.open_url url
    end

  end

end
