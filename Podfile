platform :ios,'9.0'
inhibit_all_warnings!

#多个target的pod引入
def commonPods
    pod 'Masonry'
    pod 'dsBridge'
    pod 'YYKit'
    pod 'AFNetworking'
    pod 'FFRouter'
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
  
    pod 'SnapKit'
    pod 'SwiftyJSON'
    pod 'Alamofire'
    pod 'Then'
    
    pod 'IQKeyboardManagerSwift'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'ReactiveCocoa'
    
    pod 'Kingfisher'
    
end
