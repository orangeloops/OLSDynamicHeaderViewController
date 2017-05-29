#
# Be sure to run `pod lib lint OLSDynamicHeaderViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OLSDynamicHeaderViewController'
  s.version          = '0.1.1'
  s.summary          = 'UIScrollView based component with a header view that can be animated along with scrolling'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'This is an easy to integrate view controller that allows a UIScrollView or any of their widely used subclasses (such as UITableView and UICollectionView) to have a header view that can be animated along with scrolling.
                       DESC

  s.homepage         = 'https://github.com/orangeloops/OLSDynamicHeaderViewController'
  # s.screenshots      = 'https://github.com/orangeloops/OLSDynamicHeaderViewController/blob/master/Resources/OLSDynamicHeaderDemo.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OrangeLoops' => 'ohagopian@orangeloops.com' }
  s.source           = { :git => 'https://github.com/orangeloops/OLSDynamicHeaderViewController.git', :tag => s.version.to_s }
  s.social_media_url = 'http://orangeloops.com'

  s.ios.deployment_target = '8.0'

  s.source_files = 'OLSDynamicHeaderViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'OLSDynamicHeaderViewController' => ['OLSDynamicHeaderViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
