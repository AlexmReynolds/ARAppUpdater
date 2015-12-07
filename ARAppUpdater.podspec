#
# Be sure to run `pod lib lint ARAppUpdater.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ARAppUpdater"
  s.version          = "0.1.0"
  s.summary          = "A simple to user app updater that can check for newer version"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
ARAppUpdater allows you to check for newer app versions and require or not require an update. You can check the app store for updates by passing in an app id or can check another url for updates. This is useful if your app is not on the app store or if you want more control on what is a required update
                       DESC

  s.homepage         = "https://github.com/alexmreynolds/ARAppUpdater"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Alex M Reynolds" => "alex.michael.reynolds@gmail.com" }
  s.source           = { :git => "https://github.com/alexmreynolds/ARAppUpdater.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/alexmreynolds'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ARAppUpdater' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
s.dependency 'AFNetworking', '~> 2.3'
end
