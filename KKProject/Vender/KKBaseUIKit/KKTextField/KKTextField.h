//
//  KKTextField.h
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/11/19.
//  Copyright © 2018 youbin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKTextField : UITextField

/**
 文本内容的左右边距,默认边距 12
 */
@property (nonatomic,assign) CGFloat textContainerMargin;

@end


@interface KKTextFieldView : UIView

/**
 textfiel
 */
@property (nonatomic,strong) KKTextField *textfield;

/**
 底部横线的颜色
 */
@property (nonatomic,strong) UIColor *bottomlineColor;

@end

NS_ASSUME_NONNULL_END
