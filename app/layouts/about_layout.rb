class AboutLayout < MK::Layout
  def layout
    add UIScrollView, :scroll_view do
      background_color rmq.color.background_gray
      target.scrollEnabled = true

      add UIView, :content_container do
        add UILabel, :hi_there do
          color rmq.color.black
          font rmq.font.medium
          text "Hi There."
        end

        add UILabel, :about_app do
          base_settings
          text "The Calagator IOS app is a community supported calander of technology related meetups, events, and happenings in and around Portland OR. Events are synced automatically with all events listed on the calagator website. The IOS app is sponsored and published by Notch8, a Portland based ruby and mobile software shop.  It is maintained and updated by the awesome local Ruby community.  The app is built with love using the equally awesome Ruby Motion platform."
        end

        add UILabel, :about_calagator_heading do
          base_settings
          font rmq.font.small
          text "About Calagator"
        end

        add UILabel, :about_calagator do
          base_settings
          text "Calagator is a unified calendar for the technology community of Portland, Oregon. We are an all-volunteer effort and encourage anyone to import, create, and edit events."
        end

        add UIButton, :calagator_url do
          title "http://www.calagator.org"
          background_color rmq.color.battleship_gray
          size_to_fit
        end

        add UILabel, :about_notch8_heading do
          base_settings
          font rmq.font.small
          text "About Notch8"
        end

        add UILabel, :about_notch8 do
          base_settings
          text "Notch8 is a web and mobile application software shop located in Portland, OR and San Diego, CA.  Their team of software professionals build and ship high value client applications and projects that foster a thriving technology community."
        end

        add UIButton, :notch8_url do
          background_color rmq.color.battleship_gray
          size_to_fit
          title "http://www.notch8.com"
        end


      end
    end
  end

  def base_settings
    color rmq.color.battleship_gray
    font rmq.font.small
    target.numberOfLines = 0
    size_to_fit
  end

  def add_constraints
    constraints(:scroll_view) do
      top_left x:0, y: 0
      leading 0
      trailing 0
      width.equals(:superview)
      height.equals(:superview)
    end

    constraints(:content_container) do
      top 0
      bottom 0
      leading 0
      trailing 0
      width.equals(:superview)
    end

    constraints(:hi_there) do
      top 40
      left 20
      width.equals(:superview).minus(40)
    end

    constraints(:about_app) do
      top.equals(:hi_there, NSLayoutAttributeBottom).plus(40)
      left.equals(:hi_there)
      width.equals(:superview).minus(40)
    end
    
    constraints(:about_calagator_heading) do
      top.equals(:about_app, NSLayoutAttributeBottom).plus(40)
      left.equals(:hi_there)
      width.equals(:superview).minus(40)
    end

    constraints(:about_calagator) do
      top.equals(:about_calagator_heading, NSLayoutAttributeBottom).plus(10)
      left.equals(:hi_there)
      width.equals(:superview).minus(40)
    end

    constraints(:calagator_url) do
      top.equals(:about_calagator, NSLayoutAttributeBottom).plus(10)
      left 0
      width.equals(:superview)
    end

    constraints(:about_notch8_heading) do
      top.equals(:calagator_url, NSLayoutAttributeBottom).plus(40)
      left.equals(:hi_there)
      width.equals(:superview).minus(40)
    end

    constraints(:about_notch8) do
      top.equals(:about_notch8_heading, NSLayoutAttributeBottom).plus(10)
      left.equals(:hi_there)
      width.equals(:superview).minus(40)
    end

    constraints(:notch8_url) do
      top.equals(:about_notch8, NSLayoutAttributeBottom).plus(10)
      left.equals(:calagator_url)
      width.equals(:calagator_url)
      bottom -20
    end
  end
end
