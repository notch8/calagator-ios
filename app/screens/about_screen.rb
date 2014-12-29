class AboutScreen < ProMotion::TableScreen
  include Navigation

  def on_load
    add_side_menu
  end

  def table_data
    [{
      title: "About Calagator IPhone",
      cells: [
      ]
    }]
  end
end
