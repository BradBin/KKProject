//
//  KKShareView.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/21.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 平台分享
 */

typedef void(^KKShareBlock)(void);
@interface KKShareView : UIView

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;

/**
 单例实例对象

 @return 实例对象
 */
+ (instancetype)shared;

/**
 创建分享视图

 @param items 分享数据源
 @param functions 功能数据源
 @param showBlock 显示block
 @param hideBlock 隐藏block
 @return instance
 */
- (instancetype)kk_shareWithItems:(NSArray *)items functions:(NSArray *)functions showBlock:(KKShareBlock)showBlock hideBlock:(KKShareBlock)hideBlock;;


/**
 更新ChannelView属性
 
 @param block block
 */
- (instancetype)kk_updateConfigure:(void(^)(KKShareView *shareView))block;

@end

NS_ASSUME_NONNULL_END
