//
//  KKTableViewCell.h
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/10/25.
//  Copyright © 2018 youbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTableViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

//点击cell执行的block代码块
typedef void(^DidSelectedRow)(id obj,NSIndexPath *indexPath);

@interface KKTableViewCell : UITableViewCell<KKTableViewCellProtocol>

/**
 控件容器视图
 */
@property (nonatomic,strong) UIView *containerView;

/**
 水平线对象
 */
@property (nonatomic,strong) UIView *hLineView;

/**
 垂直线对象
 */
@property (nonatomic,strong) UIView *vLineView;

/**
 创建YYLabel实例对象

 @param hidden 显示/隐藏
 @param textLayout 是否忽略除textLayout以外的属性 true:是 false:不忽略
 @return 实例对象
 */
- (YYLabel *) createLabelWithHidden:(BOOL) hidden textLayout:(BOOL) textLayout;


@end



/**
 配置Cell的badge
 */
UIKIT_EXTERN NSInteger const kkTableViewCellBadge;
@interface KKTableViewCell (KKBadge)


@end




NS_ASSUME_NONNULL_END