#
# Be sure to run `pod lib lint A4SAppDispatcherKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'A4SAppDispatcherKit'
    s.version          = '1.0.1'
    s.summary          = 'A short description of A4SAppDispatcherKit.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/ArkadiYoskovitz/A4SAppDispatcherKit'
    # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Arkadi Yoskovitz' => 'a4s.development@gmail.com' }
    s.social_media_url = 'https://twitter.com/ArkadiYoskovitz'
    s.source           = { :git => 'https://github.com/ArkadiYoskovitz/A4SAppDispatcherKit.git', :tag => s.version.to_s }
    
    s.swift_version    = '4.1'
    
    s.ios.deployment_target = '8.0'
    
    s.source_files        = 'A4SAppDispatcherKit/Classes/**/*'
    s.public_header_files = 'A4SAppDispatcherKit/Classes/**/*.h'
    s.frameworks          = 'UIKit'
    

end
