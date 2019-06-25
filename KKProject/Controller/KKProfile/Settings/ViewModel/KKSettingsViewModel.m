//
//  KKSettingsViewModel.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKSettingsViewModel.h"

NSString * const KKCellIdentifier           = @"KK.Cell.Identifier";
NSString * const KKRightLabelCellIdentifier = @"KK.Right.Label.Cell.Identifier";
NSString * const KKRightViewCellIdentifier  = @"KK.Right.View.Cell.Identifier";
@interface KKSettingsViewModel()
@property (nonatomic,strong) NSArray *dataSources;

@end

@implementation KKSettingsViewModel


-(NSArray *)dataSources{
    if (_dataSources == nil) {
        @weakify(self);
        _dataSources = @[
                         @[
                             @{
                                 @"title"         :@"多语言",
                                 @"desc"          :@"多语言",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 @"toNextVCClass" :@"KKIdentityVerifyViewController",
                                 @"clickAction"   :(^(void){
                                     @strongify(self);
                                     [self.cleanSubject sendNext:nil];
                                 })
                                 },
                             @{
                                 @"title"         :@"身份认证",
                                 @"desc"          :@"马上认证",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 @"toNextVCClass" :@"KKIdentityVerifyViewController",
                                 }
                             ],
                         @[
                             @{
                                 @"title"         :@"使用流量自动播放视频",
                                 KKCellIdentifier :KKRightViewCellIdentifier,
                                 @"notNeedArrow"  :@(YES),
                                 },
                             @{
                                 @"title"         :@"缓存大小",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 @"notNeedArrow"  :@(YES),
                                 @"clickAction"   :(^(void){
                                     @strongify(self);
                                     [self.cleanSubject sendNext:nil];
                                 })
                                 },
                             ],
                         @[
                             @{
                                 @"title"         :@"关于我们",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 @"toNextVCClass" :@"KKAboutUsViewController",
                                 }
                             ]
                         ];
    }
    return _dataSources;
}


-(RACSubject *)cleanSubject{
    if (_cleanSubject == nil) {
        _cleanSubject = RACSubject.subject;
    }
    return _cleanSubject;
}



@end
