//
//  KKTableViewHeaderFooterViewProtocol.h
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/10/25.
//  Copyright © 2018 youbin. All rights reserved.
//

@protocol KKTableViewHeaderFooterViewProtocol <NSObject>

@optional


/**
 绑定ViewModel
 */
- (void) kk_bindViewModel;


- (void)kk_setupViews;

- (void)kk_setupConfig;

@end
