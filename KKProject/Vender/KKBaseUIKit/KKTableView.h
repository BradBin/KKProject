//
//  KKTableView.h
//  ot-dayu
//
//  Created by 尤彬 on 2019/1/11.
//  Copyright © 2019 YangCK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTableViewProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@class _KKTableView;
@interface KKTableView : UIView<KKTableViewProtocol,
                                UITableViewDelegate,
                                UITableViewDataSource>

@property (nonatomic,strong) _KKTableView *tableView;

/**空视图相关设置***/
@property (nonatomic,assign) BOOL     loading; //default is false
@property (nonatomic,  copy,nullable) NSString *placerText;     //空视图提示语
@property (nonatomic,strong,nullable) NSMutableAttributedString *placerDescAttrText; //空视图描述提示语
@property (nonatomic,strong,nullable) UIImage  *placerImage;    //空视图占位图

@end



@interface _KKTableView : UITableView

@end

NS_ASSUME_NONNULL_END
