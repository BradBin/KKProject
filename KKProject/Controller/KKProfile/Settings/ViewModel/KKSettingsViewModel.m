//
//  KKSettingsViewModel.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKSettingsViewModel.h"

NSString * const KKTitle                    = @"KK.Title";
NSString * const KKDesc                     = @"KK.Desc";
NSString * const KKNextVCClass              = @"KK.NextVC.Class";

NSString * const KKNeedArrow                = @"KK.Need.Arrow";
NSString * const KKClickAction              = @"KK.Click.Action";
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
                                 KKTitle          :@"多语言",
                                 KKDesc           :@"多语言",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 KKNextVCClass    :@"KKIdentityVerifyViewController",
                                 KKClickAction    :(^(void){
                                     @strongify(self);
                                     [self.cleanSubject sendNext:nil];
                                 })
                                 },
                             @{
                                 KKTitle          :@"身份认证",
                                 KKDesc           :@"马上认证",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 KKNextVCClass    :@"KKIdentityVerifyViewController",
                                 }
                             ],
                         @[
                             @{
                                 KKTitle          :@"使用流量自动播放视频",
                                 KKCellIdentifier :KKRightViewCellIdentifier,
                                 KKNeedArrow      :@(false),
                                 },
                             @{
                                 KKTitle          :@"缓存大小",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 KKNeedArrow      :@(false),
                                 KKClickAction    :(^(void){
                                     @strongify(self);
                                     [self.cleanSubject sendNext:nil];
                                 })
                                 },
                             ],
                         @[
                             @{
                                 KKTitle          :@"关于我们",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 KKNeedArrow      :@(true),
                                 KKNextVCClass    :@"KKAboutUsViewController",
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
