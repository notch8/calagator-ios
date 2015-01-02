# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'

Bundler.require

require 'bubble-wrap/core'
require 'bundler'
require 'sugarcube-nsdate'
require 'sugarcube-numbers'

Motion::Project::App.setup do |app|
  app.name = 'Calagator'
  app.identifier = 'com.notch8.com.calagator-ios'
  app.short_version = '0.1.0'
  app.version = app.short_version
  app.sdk_version = '8.1'
  app.deployment_target = '7.1'
  app.icons = ["icon@2x.png", "icon-29@2x.png", "icon-40@2x.png", "icon-60@2x.png", "icon-76@2x.png", "icon-512@2x.png"]
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :landscape_left, :landscape_right, :portrait_upside_down]

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))
  app.fonts = ['fontawesome-webfont.ttf']
  app.frameworks += %w(CoreLocation MapKit)
  app.info_plist['UILaunchStoryboardName'] = 'launch'
 
end
