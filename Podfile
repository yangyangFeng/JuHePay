source 'https://github.com/CocoaPods/Specs.git'
source 'ssh://git@git.cnepay.net:8999/ios/cnepayspecs.git'

platform :ios, '8.0'
use_frameworks!

target 'AggregatePay' do
    
    #=========================================================
    #======================== Lib Dependency =================
    #=========================================================
    
    
    #=========================================================
    #======= pod update --verbose --no-repo-update ===========
    #=========================================================

pod 'Bugly'
pod 'MJRefresh'
pod 'MJExtension'
pod 'KVOController'
pod 'SnapKit', '~> 4.0.0'
pod 'Alamofire', '~> 4.5'
pod 'AlamofireObjectMapper', '~> 5.0'
pod 'AlamofireImage', '~> 3.3'
pod 'ESTabBarController-swift', '~> 2.5’
pod 'EFQRCode', '~> 1.2.7' # 二维码
pod 'IQKeyboardManagerSwift', '~> 5.0.6' # 键盘
pod 'SwiftTheme', '~> 0.4.1' #主题切换
pod 'Toast-Swift', '~> 3.0.1'
pod 'UMengAnalytics-NO-IDFA', '~> 4.2.5'
pod 'JPush', '~> 3.0.7'
pod 'OCRSDK/UI'
pod 'PGDatePicker', '= 1.5.9'
pod 'GTMBase64', '~> 1.0.0'
pod 'EmptyKit', '~> 4.0.0'
pod 'JPush', '~> 3.0.7'
pod 'WechatOpenSDK', '~> 1.8.1'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            #            config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end


