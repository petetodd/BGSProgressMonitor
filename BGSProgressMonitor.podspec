#
# Be sure to run `pod lib lint BGSProgressMonitor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BGSProgressMonitor'
  s.version          = '0.1.0'
  s.summary          = 'A visual Progress Monitor, useful in providing feedback on complex jobs.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Displays the progress of multisteps jobs and creates log files.  Typically used in server operations, for example uploading local data,to provide meaningful preogress feedback to the user.  The log files persist (core data) and can be queried to, for example, restart failed processes.
                       DESC

  s.homepage         = 'https://github.com/petetodd/BGSProgressMonitor'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Peter Todd' => 'peter@petertodd.com' }
  s.source           = { :git => 'https://github.com/petetodd/BGSProgressMonitor.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/petetodd'

  s.ios.deployment_target = '9.0'

  s.source_files = 'BGSProgressMonitor/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BGSProgressMonitor' => ['BGSProgressMonitor/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
