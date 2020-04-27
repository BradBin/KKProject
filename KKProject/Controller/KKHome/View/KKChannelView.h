//
//  KKChannelView.h
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^_Nullable KKChannelBlock)(void);
@interface KKChannelView : KKView

@property (nonatomic,strong) UIView   *contentView;
@property (nonatomic,strong) YYLabel  *titlelabel;
@property (nonatomic,strong) UIButton *closeBtn;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;

/**
 最小显示时间为3s
 */
@property (nonatomic,assign) NSUInteger    showDuration;

/**
 初始化ChannelView实例对象

 @param viewModel ViewModel
 @return instance
 */
+ (instancetype)kk_channelViewWithViewModel:(id<KKViewModelProtocol>)viewModel;

/**
 显示ChannelView

 @param showBlock 显示block
 @param hideBlock 隐藏block
 */
- (void)kk_showBlock:(KKChannelBlock)showBlock hideBlock:(KKChannelBlock)hideBlock;

/**
 更新ChannelView属性

 @param block block
 */
- (instancetype)kk_updateConfigure:(void(^)(KKChannelView *channelView))block;

@end

NS_ASSUME_NONNULL_END
