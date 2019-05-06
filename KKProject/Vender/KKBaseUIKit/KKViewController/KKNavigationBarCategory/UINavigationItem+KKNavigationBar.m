//
//  UINavigationItem+KKNavigationBar.m
//  KKViewControllerTest
//
//  Created by 尤彬 on 2017/10/13.
//  Copyright © 2017年 youbin. All rights reserved.
//

#import "UINavigationItem+KKNavigationBar.h"
#import "KKNavigationBarCommon.h"
#import "KKNavigationBarHelper.h"

@implementation UIImagePickerController (KKFixSpace)

+ (void)load {
    // 保证其只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        _kk_swizzled_method(class,
                            @selector(viewWillAppear:),
                            @selector(kk_viewWillAppear:));
        _kk_swizzled_method(class,
                            @selector(viewWillDisappear:),
                            @selector(kk_viewWillDisappear:));
    });
}

- (void)kk_viewWillAppear:(BOOL)animated {
    if (@available(iOS 11, *)) {
        [KKNavigationBarHelper sharedInstance].kk_disableFixSpace = YES;
    }
    [self kk_viewWillAppear:animated];
}

- (void)kk_viewWillDisappear:(BOOL)animated {
    [KKNavigationBarHelper sharedInstance].kk_disableFixSpace = NO;
    [self kk_viewWillDisappear:animated];
}

@end

@implementation UINavigationItem (KKNavigationBar)

+ (void)load {
    // 保证其只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        _kk_swizzled_method(class,
                            @selector(setLeftBarButtonItem:),
                            @selector(kk_setLeftBarButtonItem:));
        _kk_swizzled_method(class,
                            @selector(setLeftBarButtonItems:),
                            @selector(kk_setLeftBarButtonItems:));
        _kk_swizzled_method(class,
                            @selector(setLeftBarButtonItem:animated:),
                            @selector(kk_setLeftBarButtonItem:animated:));
        _kk_swizzled_method(class,
                            @selector(setLeftBarButtonItems:animated:),
                            @selector(kk_setLeftBarButtonItems:animated:));
        _kk_swizzled_method(class,
                            @selector(setRightBarButtonItem:),
                            @selector(kk_setRightBarButtonItem:));
        _kk_swizzled_method(class,
                            @selector(setRightBarButtonItems:),
                            @selector(kk_setRightBarButtonItems:));
        _kk_swizzled_method(class,
                            @selector(setRightBarButtonItem:animated:),
                            @selector(kk_setRightBarButtonItem:animated:));
        _kk_swizzled_method(class,
                            @selector(setRightBarButtonItems:animated:),
                            @selector(kk_setRightBarButtonItems:animated:));
    });
}

- (void)kk_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if (@available(iOS 11, *)) {
        [self kk_setLeftBarButtonItem:leftBarButtonItem];
    }else {
        if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace && leftBarButtonItem) {
            [self setLeftBarButtonItems:@[leftBarButtonItem]];
        }else {
            [self kk_setLeftBarButtonItem:leftBarButtonItem];
        }
    }
}

- (void)kk_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    if (@available(iOS 11, *)) {
        [self kk_setLeftBarButtonItems:leftBarButtonItems];
    }else {
        if (leftBarButtonItems.count) {
            UIBarButtonItem *firstItem = leftBarButtonItems.firstObject;
            if (firstItem != nil && firstItem.image == nil && firstItem.title == nil && firstItem.customView == nil) { // 第一个item为space
                [self kk_setLeftBarButtonItems:leftBarButtonItems];
            }else {
                NSMutableArray *items = [NSMutableArray arrayWithObject:[self _kk_fixedSpaceWithWidth:[KKNavigationBarHelper sharedInstance].kk_navItemLeftSpace - 20]]; // 修复iOS11之前的偏移
                [items addObjectsFromArray:leftBarButtonItems];
                [self kk_setLeftBarButtonItems:items];
            }
        }else {
            [self kk_setLeftBarButtonItems:leftBarButtonItems];
        }
    }
}

- (void)kk_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem animated:(BOOL)animated {
    if (@available(iOS 11, *)) {
        [self kk_setLeftBarButtonItem:leftBarButtonItem animated:animated];
    }else {
        if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace && leftBarButtonItem) {
            [self setLeftBarButtonItems:@[leftBarButtonItem] animated:animated];
        }else {
            [self kk_setLeftBarButtonItem:leftBarButtonItem animated:animated];
        }
    }
}

- (void)kk_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems animated:(BOOL)animated {
    if (@available(iOS 11, *)) {
        [self kk_setLeftBarButtonItems:leftBarButtonItems animated:animated];
    }else {
        if (leftBarButtonItems.count) {
            UIBarButtonItem *firstItem = leftBarButtonItems.firstObject;
            if (firstItem != nil && firstItem.image == nil && firstItem.title == nil && firstItem.customView == nil) {
                [self kk_setLeftBarButtonItems:leftBarButtonItems animated:animated];
            }else {
                NSMutableArray *items = [NSMutableArray arrayWithObject:[self _kk_fixedSpaceWithWidth:[KKNavigationBarHelper sharedInstance].kk_navItemLeftSpace - 20]];
                [items addObjectsFromArray:leftBarButtonItems];
                [self kk_setLeftBarButtonItems:items animated:animated];
            }
        }else {
            [self kk_setLeftBarButtonItems:leftBarButtonItems animated:animated];
        }
    }
}

- (void)kk_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    if (@available(iOS 11, *)) {
        [self kk_setRightBarButtonItem:rightBarButtonItem];
    }else {
        if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace && rightBarButtonItem) {
            [self setRightBarButtonItems:@[rightBarButtonItem]];
        }else {
            [self kk_setRightBarButtonItem:rightBarButtonItem];
        }
    }
}

- (void)kk_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems {
    if (@available(iOS 11, *)) {
        [self kk_setRightBarButtonItems:rightBarButtonItems];
    }else {
        if (rightBarButtonItems.count) {
            UIBarButtonItem *firstItem = rightBarButtonItems.firstObject;
            if (firstItem != nil && firstItem.image == nil && firstItem.title == nil && firstItem.customView == nil) {
                [self kk_setRightBarButtonItems:rightBarButtonItems];
            }else {
                NSMutableArray *items = [NSMutableArray arrayWithObject:[self _kk_fixedSpaceWithWidth:[KKNavigationBarHelper sharedInstance].kk_navItemRightSpace - 20]]; // 可修正iOS11之前的偏移
                [items addObjectsFromArray:rightBarButtonItems];
                [self kk_setRightBarButtonItems:items];
            }
        }else {
            [self kk_setRightBarButtonItems:rightBarButtonItems];
        }
    }
}

- (void)kk_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem animated:(BOOL)animated {
    if (@available(iOS 11, *)) {
        [self kk_setRightBarButtonItem:rightBarButtonItem animated:animated];
    }else {
        if (![KKNavigationBarHelper sharedInstance].kk_disableFixSpace && rightBarButtonItem) {
            [self setRightBarButtonItems:@[rightBarButtonItem] animated:animated];
        }else {
            [self kk_setRightBarButtonItem:rightBarButtonItem animated:animated];
        }
    }
}

- (void)kk_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems animated:(BOOL)animated {
    if (@available(iOS 11, *)) {
        [self kk_setRightBarButtonItems:rightBarButtonItems animated:animated];
    }else {
        if (rightBarButtonItems.count) {
            UIBarButtonItem *firstItem = rightBarButtonItems.firstObject;
            if (firstItem != nil && firstItem.image == nil && firstItem.title == nil && firstItem.customView == nil) {
                [self kk_setRightBarButtonItems:rightBarButtonItems animated:animated];
            }else {
                NSMutableArray *items = [NSMutableArray arrayWithObject:[self _kk_fixedSpaceWithWidth:[KKNavigationBarHelper sharedInstance].kk_navItemRightSpace - 20]]; // 可修正iOS11之前的偏移
                [items addObjectsFromArray:rightBarButtonItems];
                [self kk_setRightBarButtonItems:items animated:animated];
            }
        }else {
            [self kk_setRightBarButtonItems:rightBarButtonItems animated:animated];
        }
    }
}

- (UIBarButtonItem *)_kk_fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
