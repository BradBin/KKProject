//
//  KKUIKit.h
//  kkorange
//
//  Created by YangCK on 2018/4/17.
//  Copyright © 2018年 YangCK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKButton.h"
#import "KKTextField.h"
#import "KKLabel.h"

@interface KKUIKit : NSObject

/*!
 @brief 初始化label
 @param font          字体样式
 @param textColor     字体颜色
 @param textAlignment 换行方式
 @param numberOfLines 行数
 @param text          文字
 */
+ (KKLabel *)labelWithFont:(UIFont *)font
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)textAlignment
             numberOfLines:(NSInteger)numberOfLines
                      text:(NSString *)text;

/*!
 @brief 初始化button
 @param backgroundColor 背景色
 @param titleColor      字体颜色
 @param normalImage     正常模式图片
 @param selectImage     选中模式图片
 @param title           文字
 @param titleFont       字号大小
 */
+ (KKButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                              titleColor:(UIColor *)titleColor
                             normalImage:(UIImage *)normalImage
                             selectImage:(UIImage *)selectImage
                                   title:(NSString *)title
                               titleFont:(UIFont *)titleFont;
/*!
 @brief 初始化button （背景图）
 @param backgroundColor 背景色
 @param titleColor      字体颜色
 @param normalImage     正常模式背景图片
 @param selectImage     选中模式背景图片
 @param title           文字
 @param titleFont       字号大小
 */
+ (KKButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                              titleColor:(UIColor *)titleColor
                         normalBackImage:(UIImage *)normalImage
                         selectBackImage:(UIImage *)selectImage
                                   title:(NSString *)title
                               titleFont:(UIFont *)titleFont;
/*!
 @brief 初始化view
 @param backgroundColor 背景色
 */
+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor;

/*!
 @brief 初始化imageView
 @param backgroundColor 背景色
 @param image           显示图片
 @param contentMode     填充模式
 */
+ (UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgroundColor
                                        image:(UIImage *)image
                                  contentMode:(UIViewContentMode)contentMode;

/*!
 @brief 初始化textView
 @param backgroundColor 背景色
 @param font            字体样式
 @param textColor       字体颜色
 @param textAlignment   换行方式
 @param text            文字
 */
+ (UITextView *)textViewWithBackgroundColor:(UIColor *)backgroundColor
                                       font:(UIFont *)font
                                  textColor:(UIColor *)textColor
                              textAlignment:(NSTextAlignment)textAlignment
                                       text:(NSString *)text;

/*!
 @brief 初始化textField
 @param backgroundColor 背景色
 @param font            字体样式
 @param textColor       字体颜色
 @param textAlignment   换行方式
 @param borderStyle     边框样式
 @param placeholder     提示信息
 @param clearButtonMode 清除button模式
 @param keyboardType    键盘样式
 */
+ (KKTextField *)textFieldWithBackgroundColor:(UIColor *)backgroundColor
                                  borderStyle:(UITextBorderStyle)borderStyle
                                         font:(UIFont *)font
                                    textColor:(UIColor *)textColor
                                textAlignment:(NSTextAlignment)textAlignment
                                  placeholder:(NSString *)placeholder
                              clearButtonMode:(UITextFieldViewMode)clearButtonMode
                                 keyboardType:(UIKeyboardType)keyboardType;

/*!
 @brief 初始化UIWebView
 @param delegate 代理
 */
+ (UIWebView *)webViewWithDelegate:(id<UIWebViewDelegate>)delegate;

@end
