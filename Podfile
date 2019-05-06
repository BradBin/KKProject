platform :ios,'9.0'
inhibit_all_warnings!

#多个target的pod引入
def commonPods
  pod 'Masonry'
  pod 'dsBridge'
  pod 'YYKit'
  pod 'AFNetworking'
  pod 'CYLTabBarController'
  
  pod 'EasyReact'
  pod 'ReactiveObjC'
  pod 'FFRouter'
  pod 'BlockHook'
  
  pod 'SVGAPlayer'
  pod 'SVGKit'
  pod 'MJRefresh'
  pod 'GPUImage'
  
  #  pod 'PromiseKit'
end

target 'KKProject' do
  commonPods
  
  #腾讯Bugly
  pod 'Bugly'
  #循环引用检测工具
  pod 'FBRetainCycleDetector'
end

target 'KKProject_Objc' do
  commonPods
  #友盟-基础组件
  pod 'UMCCommon'
  pod 'UMCSecurityPlugins'
  pod 'UMCCommonLog'
  #友盟-消息推送
  pod 'UMCPush'
  #友盟-移动统计
  pod 'UMCAnalytics'
  #友盟-分享/第三方登录
  pod 'UMCShare/UI'
  #pod 'UMCShare/Social/WeChat'
  pod 'UMCShare/Social/ReducedWeChat'
  pod 'UMCShare/Social/QQ'
  
  pod 'IQKeyboardManager'
  pod 'NIMSDK_LITE', '~> 6.4.0'
end


#targets = ['KKProject','KKProject_Objc']
#targets.each do |t|
#    target t do
#        pod 'Masonry'
#        pod 'dsBridge'
#        pod 'YYKit'
#        pod 'AFNetworking'
#    end
#end


target 'KKProject_Swift' do
  use_frameworks!
  
  pod 'SwiftLint'
  
  
  pod 'SnapKit'
  pod 'SwiftyJSON'
  pod 'Alamofire'
  pod 'Moya'
  pod 'Then'
  
  pod 'IQKeyboardManagerSwift'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'ReactiveCocoa'
  
  pod 'Kingfisher'
  
  
  pod 'Material'
  pod 'Atributika'
  pod 'PromiseKit'
  
  pod 'AsyncSwift'
  pod 'Surge'
  pod 'CryptoSwift'
  pod 'KeychainAccess'
  pod 'SwiftyUserDefaults'
  
  pod 'SQLite.swift'
  pod 'R.swift'
  pod 'ReachabilitySwift'
  pod 'SwiftDate'
  
  pod 'SwiftMessages'
  pod 'SwiftEntryKit'
  pod 'Advance'
  
  pod 'SwiftyStoreKit'
  pod 'Instructions'
  
  
  
  pod 'AnimatedCollectionViewLayout'
  pod 'CollectionKit'
  pod 'Cards'
  
  pod 'SwipeCellKit'
  pod 'ViewAnimator'
  pod 'XLPagerTabStrip'
  pod 'RAMAnimatedTabBarController'
  pod 'Eureka'
  pod 'FoldingCell'
  pod 'NVActivityIndicatorView'
  pod 'SkeletonView'
  pod 'expanding-collection'
  pod 'LTMorphingLabel'
  
end



#***********
#Build system information
#Xcode 9 --> deployment target 4.3
#Xcode 10 --> deployment target 8.0
#Xcode10的这次更新直接把deployment target提到了8.0，故之前的一些第三方库会出现这样的问题。
#*********
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end
