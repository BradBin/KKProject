//
//  UISearchBar+KKAdd.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/20.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "UISearchBar+KKAdd.h"

@implementation UISearchBar (KKAdd)

- (UITextField *)searchBarTextfield{
    UITextField *textfield = [self valueForKey:@"searchField"];
    return textfield;
}

- (void)setTextFont:(UIFont *)font{
    if (@available(iOS 9.0 , *)) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
    }else{
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:font];
    }
}

- (void)setTextColor:(UIColor *)textColor{
    if (@available(iOS 9.0 , *)) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    }else{
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:textColor];
    }
}

- (void)setCancelButtonTitle:(NSString *)title{
    if (@available(iOS 9.0 , *)) {
        [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = title;
    }else{
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

- (void)setCancelButtonFont:(UIFont *)font{
    NSDictionary *textAttr = @{NSFontAttributeName : font};
    if (@available(iOS 9.0 , *)) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    }else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    }
}

@end
