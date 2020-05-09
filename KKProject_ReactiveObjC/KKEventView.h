//
//  KKEventView.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/8.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/*****************************
 
    iOS的事件传递和响应机制
 
 能够处理事件都必须继承自UIResponder(响应者对象)
 
 1.处理触摸事件 2.加速计事件 3.远程控制事件
 
 事件的传递顺序:
 产生触摸事件-->UIApplication事件队列-->[UIWindow hitTest:withEvent:]-
 -返回合适view-->[子控件 hitTest:withEvent:]-->返回最合适的view
 
 寻找最合适的view(两个重要的方法)
  1.hitTest:withEvent:方法(只要事件传递给下一个空间,就调用此方法)
  2.pointInside方法
 
 ##技巧：想让谁成为最合适的view就重写谁自己的父控件的hitTest:withEvent:方法返回指定的子控件，或者重写自己的hitTest:withEvent:方法 return self。但是，建议在父控件的hitTest:withEvent:中返回子控件作为最合适的view.
 
 
 pointInside:withEvent:方法:判断点在不在当前view上（方法调用者的坐标系上）如果返回YES，代表点在方法调用者的坐标系上;返回NO代表点不在方法调用者的坐标系上，那么方法调用者也就不能处理事件。
 

*******************************/

@interface KKEventView : UIView

@property (nonatomic, strong) UIView *eventSubView;

@property (nonatomic, strong) UIButton *roundButton;


@end

NS_ASSUME_NONNULL_END
