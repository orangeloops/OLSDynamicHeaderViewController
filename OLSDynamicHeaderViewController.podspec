#
# Be sure to run `pod lib lint OLSDynamicHeaderViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OLSDynamicHeaderViewController'
  s.version          = '1.0.0'
  s.summary          = 'UIScrollView based component with a header view that can be animated along with scrolling'
  s.description      = <<-DESC
  'This is an easy to integrate view controller that allows a UIScrollView or any of their widely used subclasses (such as UITableView and UICollectionView) to have a header view that can be animated along with scrolling.
                         DESC

  s.homepage         = 'https://github.com/orangeloops/OLSDynamicHeaderViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OrangeLoops' => 'ohagopian@orangeloops.com' }
  s.source           = { :git => 'https://github.com/orangeloops/OLSDynamicHeaderViewController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/orangeloopsinc'
  s.ios.deployment_target = '11.0'
  s.source_files = 'OLSDynamicHeaderViewController/Classes/**/*'
  s.swift_versions = ['5.0']
end
