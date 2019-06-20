//
//  UISearchBar+KKAdd.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/20.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (KKAdd)

- (UITextField *)searchBarTextfield;

- (void)setTextFont:(UIFont *)font;
- (void)setTextColor:(UIColor *)textColor;
- (void)setCancelButtonTitle:(NSString *)title;
- (void)setCancelButtonFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
