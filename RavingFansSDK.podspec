#
# Be sure to run `pod lib lint RavingFansSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RavingFansSDK'
  s.version          = '1.1.0'
  s.summary          = 'SDK for working with RavingFans. See http://followtheseed.vc/ for details.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SDK for working with RavingFans.

Register at http://followtheseed.vc, integrate this SDK to your project and let the data flow.
                       DESC

  s.homepage         = 'https://github.com/RavingFans/ravingfans-ios-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ko0f' => '6340033+ko0f@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/RavingFans/ravingfans-ios-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RavingFansSDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RavingFansSDK' => ['RavingFansSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
