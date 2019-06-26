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
NSString * const KKTextFieldCellIdentifier  = @"KK.TextField.Cell.Identifier";

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
                                 KKNeedArrow      :@(true),
                                 KKClickAction    :(^(void){
                                     @strongify(self);
                                     [self.changeLanguageSubject sendNext:@(true)];
                                 })
                                 },
                             @{
                                 KKTitle          :@"身份认证",
                                 KKDesc           :@"马上认证",
                                 KKNeedArrow      :@(false),
                                 KKCellIdentifier :KKRightLabelCellIdentifier
                                 }
                             ],
                         @[
                             @{
                                 KKTitle          :@"WiFi自动播放视频",
                                 KKCellIdentifier :KKRightViewCellIdentifier,
                                 KKNeedArrow      :@(false),
                                 },
                             @{
                                 KKTitle          :@"缓存大小",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 KKNeedArrow      :@(false),
                                 KKClickAction    :(^(void){
                                     @strongify(self);
                                     [self.cleanSubject sendNext:@(KKCacheTypeImageCache)];
                                 })
                                 },
                             @{
                                 KKTitle          :@"聊天记录",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 KKNeedArrow      :@(false),
                                 KKClickAction    :(^(void){
                                     @strongify(self);
                                     [self.cleanSubject sendNext:@(KKCacheTypeChatRecord)];
                                 })
                                 }
                             ],
                         
                         @[
                             @{
                                 KKTitle          :@"电话",
                                 KKCellIdentifier :KKTextFieldCellIdentifier,
                                 KKNeedArrow      :@(true),
                                 },
                             @{
                                 KKTitle          :@"手机",
                                 KKCellIdentifier :KKTextFieldCellIdentifier,
                                 KKNeedArrow      :@(false),
                                 }
                             ],
                         @[
                             @{
                                 KKTitle          :@"关于我们",
                                 KKCellIdentifier :KKRightLabelCellIdentifier,
                                 KKNeedArrow      :@(true),
                                 KKNextVCClass    :@"KKAboutusViewController",
                                 }
                             ]
                         ];
    }
    return _dataSources;
}

-(RACSubject *)pushVCSubject{
    if (_pushVCSubject == nil) {
        _pushVCSubject = RACSubject.subject;
    }
   return _pushVCSubject;
}

-(RACSubject *)changeLanguageSubject{
    if (_changeLanguageSubject == nil) {
        _changeLanguageSubject = RACSubject.subject;
    }
    return _changeLanguageSubject;
}

-(RACSubject *)cleanSubject{
    if (_cleanSubject == nil) {
        _cleanSubject = RACSubject.subject;
    }
    return _cleanSubject;
}



@end
