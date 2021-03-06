Calagator IOS App
===================

Portland, Oregon's Mobile technology Calendar
--------------------------------------------

Calagator is The tech calendar for meetups, events, and happenings around the Portland area having to do with technology.  The [online calendar](http://calagator.org) and the app are free to use and add your own events.  You are warmly encouraged to get involved in developing both this IOS app, and the [calagator.org](https://github.com/calagator/calagator) site itself, which is a [Ruby on Rails](http://www.rubyonrails.org) site.  This app was build on the most excellent [Ruby Motion](http://rubymotion.com) platform.  Experienced, and developers gaining experience are equally welcome here.  You will learn a lot, and you can contribute a lot.  This code is all open source, a great resume builder, and your code will benefit many thousands of Portland technologists who rely on Calagator to stay connected.  Strangers will thank you and buy you beer, and you really will be almost as awesome, but not quite as awesome as your dog/cat/chinchilla thinks that you are.

Features
----------

|List of Upcomming events|Event Details|Set Alerts for Events|
|---|---|---|
| ![event list](https://raw.githubusercontent.com/notch8/calagator-ios/master/docs/list.png)| ![details](https://raw.githubusercontent.com/notch8/calagator-ios/master/docs/details.png)| ![alerts](https://raw.githubusercontent.com/notch8/calagator-ios/master/docs/alerts.png)|

|Customize Alerts|All devices, and Landscape view supported|
|---|---|
|![customize](https://raw.githubusercontent.com/notch8/calagator-ios/master/docs/options.png)| ![landscape](https://raw.githubusercontent.com/notch8/calagator-ios/master/docs/landscape.png) |

Is the IOS app for other cities who use Calagator?
--------------------------------------------------

Yep, it sure can be.  Calagator-IOS is open source, under the MIT licence.  Pointing it at your install of Calagator is as easy as changing the CALAGATOR_URL line in the [event model](https://github.com/notch8/calagator-ios/blob/master/app/models/event.rb) file to point to your website.  Changing the colors is done in [application stylesheet](https://github.com/notch8/calagator-ios/blob/master/app/stylesheets/application_stylesheet.rb).  On the wishlist below is adding the ability for users to switch between cities right in the app.  If you use Calagator, and want to be included in the app, open an issue and let us know.

How can you get involved?
--------------------------

Its easy.  Make sure you have [Ruby Motion](http://rubymotion.com) installed, then just fork this repo, and submit a PR with your changes.  Its a good idea to send an email to the [PDX Tech Calendar](https://groups.google.com/forum/#!forum/pdx-tech-calendar) group to talk through your plans with the others working on the app.  Also, be sure to keep an eye open for hackathons on Calagator that happen every once in a while.  Its a good opportunity to meet the good folk behind the project.


Getting Started on the IOS App
------------------------------
1. Sign up for the [PDX Tech Calendar](https://groups.google.com/forum/#!forum/pdx-tech-calendar)
2. Get a license for [Ruby Motion](http://rubymotion.com) 
3. Fork the repo
4. Read over the contribution guidelines below.
4. Write a failing spec for the thing you want to change
5. Make your updates
6. Submit a PR with your specs and code changes


Contribution Guidelines
-----------------------
1. Everything should be tested.  Write a failing spec before you write production code.
2. The app uses Auto Layout, so please make sure that you code looks great on all device sizes, and in all orientations.
3. Specs and documentation are equally valued contributions.  Please help where you can.


Wishlist
---------
1. add link to questions/feedback
2. change menu background to dark gray
3. add ability to switch which Calagator website the app uses.
