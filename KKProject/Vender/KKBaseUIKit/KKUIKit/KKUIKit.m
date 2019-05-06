//
//  KKUIKit.m
//  kkorange
//
//  Created by YangCK on 2018/4/17.
//  Copyright © 2018年 YangCK. All rights reserved.
//

#import "KKUIKit.h"

@implementation KKUIKit

+ (KKLabel *)labelWithFont:(UIFont *)font
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)textAlignment
             numberOfLines:(NSInteger)numberOfLines
                      text:(NSString *)text {
    
    KKLabel * label = [[KKLabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.text = text;
    return label;
}

+ (KKButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                              titleColor:(UIColor *)titleColor
                             normalImage:(UIImage *)normalImage
                             selectImage:(UIImage *)selectImage
                                   title:(NSString *)title
                               titleFont:(UIFont *)titleFont {
    
    KKButton * button = [KKButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    if (selectImage) {
        [button setImage:selectImage forState:UIControlStateSelected];
    }
    button.titleLabel.font = titleFont;
    
    return button;
}

+ (KKButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                              titleColor:(UIColor *)titleColor
                         normalBackImage:(UIImage *)normalImage
                         selectBackImage:(UIImage *)selectImage
                                   title:(NSString *)title
                               titleFont:(UIFont *)titleFont {
    
    KKButton * button = [KKButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    if (normalImage) {
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    if (selectImage) {
        [button setBackgroundImage:selectImage forState:UIControlStateSelected];
    }
    button.titleLabel.font = titleFont;
    
    return button;
}

+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor {
    
    UIView * view = [UIView new];
    view.backgroundColor = backgroundColor;
//    if (view.backgroundColor == [UIColor clearColor]) {
//        view.opaque = NO;
//    }
    return view;
}

+ (UITextView *)textViewWithBackgroundColor:(UIColor *)backgroundColor
                                       font:(UIFont *)font
                                  textColor:(UIColor *)textColor
                              textAlignment:(NSTextAlignment)textAlignment
                                       text:(NSString *)text {
    
    UITextView * textView = [UITextView new];
    textView.backgroundColor = backgroundColor;
    if (textView.backgroundColor == [UIColor clearColor]) {
        textView.opaque = NO;
    }
    textView.font = font;
    textView.textColor = textColor;
    textView.textAlignment = textAlignment;
    textView.text = text;
    return textView;
}

+ (UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgroundColor
                                        image:(UIImage *)image
                                  contentMode:(UIViewContentMode)contentMode {
    
    UIImageView * imageView = [UIImageView new];
    imageView.backgroundColor = backgroundColor;
    imageView.image = image;
    imageView.contentMode = contentMode;
    return imageView;
}

+ (KKTextField *)textFieldWithBackgroundColor:(UIColor *)backgroundColor
                                  borderStyle:(UITextBorderStyle)borderStyle
                                         font:(UIFont *)font
                                    textColor:(UIColor *)textColor
                                textAlignment:(NSTextAlignment)textAlignment
                                  placeholder:(NSString *)placeholder
                              clearButtonMode:(UITextFieldViewMode)clearButtonMode
                                 keyboardType:(UIKeyboardType)keyboardType {
    
    KKTextField * textField = [[KKTextField alloc] init];
    textField.backgroundColor = backgroundColor;
    textField.borderStyle = borderStyle;
    textField.font = font;
    textField.textColor = textColor;
    textField.textAlignment = textAlignment;
    textField.placeholder = placeholder;
    textField.clearButtonMode = clearButtonMode;
    textField.keyboardType = keyboardType;
    return textField;
}

+ (UIWebView *)webViewWithDelegate:(id<UIWebViewDelegate>)delegate {
    
    UIWebView * webView = [UIWebView new];
    webView.delegate = delegate;
    return webView;
}

@end
