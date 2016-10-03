# Uncomment this line to define a global platform for your project
platform :ios, '8.0'

target 'CJWUtilsS' do
    use_frameworks!
    pod 'AFNetworking'
    pod 'SDWebImage'
    pod 'MJRefresh'
    pod 'FlatUIKit'
    pod 'MBProgressHUD'
    pod 'CGFloatType'
    pod 'DZNEmptyDataSet'
    pod 'NSDate+TimeAgo'
    pod 'MJExtension'
    pod 'ClusterPrePermissions'
    pod 'FCFileManager'
    pod 'LKDBHelper'
    pod 'FLKAutoLayout'
    pod 'Alamofire'
    pod 'KLCPopup'
    pod 'CocoaLumberjack/Swift'
    
    pod 'SVProgressHUD'
    pod 'SSKeychain'
    #    pod 'SugarRecord'
    #    pod 'Realm', :tag ~> '0.97.0'
    #    pod 'Realm', '~> 0.97.0'
    #    pod 'RealmSwift'
#    pod 'AsyncSwift'
    #- swift date operation
#    pod 'AFDateHelper'
    # remain testing
#    pod 'Signals'
#    pod 'TaskQueue'
    #log net work status , remain testing
#    pod 'netfox'
    # swift timer , seems usable, remain testing
    #store any object in your user default,but it's not that usefull
    #pod 'Prephirences'
    # common user default,recommand
#    pod 'YYModel'
    pod 'WebViewJavascriptBridge'
    pod 'AwesomeCache', '~> 2.0'
#    pod 'FXBlurView'
    #    pod 'Mirror', :git => 'https://github.com/kostiakoval/Mirror.git', :branch => 'swift-2.0'
#    pod ’Bugly’
#
    #    pod 'ImagePickerSheetController'
#    pod 'SnapKit'
    pod 'SwiftyRSA'
    #    pod ’AMap2DMap’
    
#    pod 'SwiftyTimer'
#pod 'SwiftyUserDefaults'

    pod ’INTULocationManager’
    pod 'CocoaLumberjack','2.4.0'
    pod 'PromiseKit', "~> 3.5"
    pod 'CryptoSwift','0.5.2 '
    pod 'XCGLogger','3.3'
#    pod 'SwiftDate','3.0.9'
    pod 'SwiftyJSON','2.4.0'
    pod 'HMSegmentedControl','1.5.2'
    pod 'AsyncSwift','~>1.7.2'
    pod 'PhoneNumberKit'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '2.3'
            end
        end
    end
    
end

target 'CJWUtilsSTests' do
    
end

