#
#  Be sure to run `pod spec lint CJWUtils.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "CJWUtilsS"
  s.version      = "1.0.0"
  s.summary      = "CJWUtilsS is sort of tools for iOS develop written by swift"

  s.description  = <<-DESC
                   A longer description of CJWUtils in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/frankcjwen/CJWUtilsS"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  #s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #
  
  s.author             = { "frank" => "fk911c@gmail.com" }
  # Or just: s.author    = "frank"
  # s.authors            = { "frank" => "fk911c@gmail.com" }
  # s.social_media_url   = "http://twitter.com/frank"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  #s.source       = { :git => "https://github.com/frankcjwen/CJWUtilsS.git", :tag => "0.0.1" }
  s.source       = { :git => "https://github.com/frankcjw/CJWUtilsS.git"  }
  
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any h, m, mm, c & cpp files. For header
  #  files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "Classes", "CJWUtilsS/QPLib/**/*.swift", "CJWUtilsS/utils/*.swift", "CJWUtilsS/QPLib/Lib/**/*.*","CJWUtilsS/QPLib/UI/**/*.*"
  #s.source_files  = "Classes", "CJWUtilsS/utils/**/*"
  s.exclude_files = "Classes/Exclude"

s.subspec 'CJWUtils' do |ss|
    #ss.source = { :git => 'https://github.com/frankcjw/CJWUtils.git'}
#ss.dependency "Bugly"
#ss.pod_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PODS_ROOT)/Bugly' }
#ss.framework = 'Bugly'
#ss.ios.library = 'Bugly'
#ss.vendored_framework = 'Bugly'
end

#s.public_header_files = "CJWUtilsS/QPLib/QPHeader.h"
#s.public_header_files = 'Bugly.framework/Headers/bugly.h'

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  s.resources = "CJWUtilsS/QPLib/Lib/MLSelectPhoto/MLSelectPhoto.bundle"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.framework  = "UIKit","SystemConfiguration"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
#s.xcconfig = { 'SWIFT_OBJC_BRIDGING_HEADER' => 'CJWUtilsS/QPLib/QPHeader.h' }
  # s.dependency "JSONKit", "~> 1.4"
  s.dependency "AFNetworking"
  s.dependency "SDWebImage"
  s.dependency "MJRefresh"
  s.dependency "FlatUIKit"
  s.dependency "MBProgressHUD"
  s.dependency "CGFloatType"
  s.dependency "DZNEmptyDataSet"
  s.dependency "NSDate+TimeAgo"
  s.dependency "HMSegmentedControl"
  s.dependency "MJExtension"
  s.dependency "ClusterPrePermissions"
  s.dependency "FCFileManager"
  s.dependency "LKDBHelper"
  s.dependency "FLKAutoLayout"
  s.dependency "Alamofire"
  s.dependency "KLCPopup"
  s.dependency "XCGLogger",'3.3'
  s.dependency "SwiftyJSON"
  s.dependency "SVProgressHUD"
  s.dependency "SSKeychain"
  s.dependency "AsyncSwift",'~>1.7.2'
  s.dependency "CGFloatType"
  s.dependency "CryptoSwift",'~>0.4.1'
  s.dependency "PhoneNumberKit"
  #s.dependency "AMap2DMap"
  s.dependency "INTULocationManager"
  s.dependency "AwesomeCache", "~> 2.0"
  s.dependency "GPUImage"
  s.dependency "SwiftyRSA"
#s.dependency "Bugly"
#s.framework = 'Bugly'
  #s.dependency "RealmSwift", "~> 0.97.0"
  #s.dependency {'Mirror', :git => 'https://github.com/kostiakoval/Mirror.git', :branch => 'swift-2.0'}

  #s.dependency "TMCache"
#  s.dependency "MLSelectPhoto"
#s.dependency 'MLSelectPhoto', :git => 'https://github.com/CJWDevelop/MLSelectPhoto'
#s.dependency 'MLSelectPhoto', :git => 'https://github.com/CJWDevelop/MLSelectPhoto'
end
