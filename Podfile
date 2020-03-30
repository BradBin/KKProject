platform :ios,'12.2'
inhibit_all_warnings!

#多个target的pod引入
def commonPods
  pod 'Masonry'
  pod 'dsBridge'
  pod 'YYKit'
  pod 'AFNetworking'
  pod 'IQKeyboardManager'
  
  pod 'EasyReact'
  pod 'ReactiveObjC'
  pod 'FFRouter'
  pod 'BlockHook', '~> 1.5.6'
  
  pod 'MBProgressHUD'
  
  pod 'SVGAPlayer'
  pod 'SVGKit'
  #刷新库
  pod 'MJRefresh'
  #图像处理库
  pod 'GPUImage'
  #tabBar标签控制器
  pod 'CYLTabBarController', '~> 1.28.5'
  #昼夜模式切换
  pod 'DKNightVersion'
  #滚动标签
  pod 'JXCategoryView'
  
  #网易云信sdk
  pod 'NIMSDK'
  
end

target 'KKProject' do
  commonPods
  #社交软件
  pod 'OpenShare'
  #腾讯Bugly
  pod 'Bugly'
  #循环引用检测工具
  pod 'FBRetainCycleDetector'
  
  #3体云SDK-声音
#  pod 'TTTRtcEngineVoiceKit_iOS'
#  pod 'TTTPlayerKit_iOS'
    
  
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
  
  #视频播放器
  #  pod 'SGPlayer'
  
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
  
  #auto layout
  pod 'SnapKit', '~> 5.0.1'

  pod 'Then', '~> 2.6.0'
  pod 'thenPromise'
  
  #数据模型解析
  pod 'HandyJSON', '~> 5.0.1'
  pod 'SwiftyJSON', '~> 5.0.0'
  
  #组件化工具库
  pod 'BeeHive'
  
  pod 'IQKeyboardManagerSwift'
  
  
  #对Alamofire的二次封装
  pod 'Moya/RxSwift'
  
#  pod 'RxSwift', '~> 5.0.1'
#  pod 'RxCocoa', '~> 5.0.1'
  
  pod 'Moya/ReactiveSwift'
  pod 'ReactiveCocoa'
#  pod 'ReactiveCocoa', '~> 10.2.0'
  
  #资源引用工具
  pod 'R.swift', '~> 5.1.0'
  
  #图片加载处理框架
  pod 'Kingfisher', '~> 5.13.0'
  
  #定时器
  pod 'Repeat', '~> 0.6.0'
  
  #queue manager
  pod 'Queuer', '~> 2.1.1'
  
  pod 'Material', '~> 3.1.8'
  pod 'Atributika'
  pod 'PromiseKit'
  
  pod 'AsyncSwift'
  pod 'Surge'
  pod 'CryptoSwift'
  pod 'KeychainAccess'
  pod 'SwiftyUserDefaults'
  
  pod 'SQLite.swift', '~> 0.12.2'
  
  pod 'ReachabilitySwift'
  pod 'SwiftDate'
  
  pod 'SwiftMessages'
  pod 'SwiftEntryKit'
  
  #pod 'Advance'
  
  pod 'SwiftyStoreKit'
  pod 'Instructions'
  
  #颜色
  pod 'DynamicColor'
  
  #自定义导航栏
  pod 'EachNavigationBar', '~> 1.14.3'
  
  #TabBar
  pod 'RAMAnimatedTabBarController', '~> 5.1.0'
  pod 'ESTabBarController-swift', '~> 2.8.0'
  
  #占位视图
  pod 'EmptyDataSet-Swift', '~> 5.0.0'
  
  #滚动标签 segmented view
  pod 'JXSegmentedView', '~> 1.0.4'
  
  pod 'AnimatedCollectionViewLayout'
  pod 'CollectionKit'
  pod 'Cards'
  
  pod 'SwipeCellKit'
  pod 'ViewAnimator', '~> 2.7.0'
  pod 'XLPagerTabStrip'
  
  #Elegant iOS forms
#  pod 'Eureka', '~> 5.2.0'
  
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
