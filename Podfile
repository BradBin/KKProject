platform :ios,'9.0'
inhibit_all_warnings!

#多个target的pod引入
def commonPods
  pod 'Masonry'
  pod 'dsBridge'
  pod 'YYKit'
  pod 'AFNetworking'
  pod 'FFRouter'
  
  pod 'SVGAPlayer'
  pod 'SVGKit'
  
  #  pod 'PromiseKit'
end

target 'KKProject' do
  commonPods
  pod 'EasyReact'
  #循环引用检测工具
  pod 'FBRetainCycleDetector'
end

target 'KKProject_Objc' do
  commonPods
  pod 'ReactiveObjC'
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
  pod 'CocoaLumberjack/Swift'
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
  pod 'Whisper'
  pod 'SwiftEntryKit'
  pod 'Advance'
  
  pod 'SwiftyStoreKit'
  pod 'Instructions'
  
  pod 'ImagePicker'
  
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
