#
# Be sure to run `pod lib lint ibohonos2018.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ibohonos2018'
  s.version          = '0.1.0'
  s.summary          = 'Now that your pod is created you have to take care about its podspec file.'
  s.swift_version    = '4.0.3'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Now that your pod is created you have to take care about its podspec file. Now that your pod is created you have to take care about its podspec file. Now that your pod is created you have to take care about its podspec file
                       DESC

  s.homepage         = 'https://github.com/ibohonos/ibohonos2018'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ibohonos' => 'ibohonos@student.unit.ua' }
  s.source           = { :git => 'https://github.com/ibohonos/ibohonos2018.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ibohonos2018/Classes/**/*'
  s.resource = 'ibohonos2018/Assets/*'
  
  # s.resource_bundles = {
  #   'ibohonos2018' => ['ibohonos2018/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
