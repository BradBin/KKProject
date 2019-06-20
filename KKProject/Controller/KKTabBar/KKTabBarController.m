//
//  KKTabBarController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTabBarController.h"
#import "KKHomeViewController.h"
#import "KKTidingViewController.h"
#import "KKFindViewController.h"
#import "KKProfileViewController.h"

@interface KKTabBarController ()<UITabBarControllerDelegate,CYLTabBarControllerDelegate>

@end

@implementation KKTabBarController

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    CYLTabBarController *tabBar = [CYLTabBarController tabBarControllerWithViewControllers:self.controllers
                                                                     tabBarItemsAttributes:self.tabBarAttributes
                                                                               imageInsets:imageInsets
                                                                   titlePositionAdjustment:titlePositionAdjustment
                                                                                   context:nil];
    [self customizeTabBarAppearance:tabBar];
    
    return  (self = (KKTabBarController*)tabBar);
    
}


- (NSArray *) controllers{
    KKHomeViewController    *homeVC    = KKHomeViewController.new;
    KKTidingViewController  *tidingsVC = KKTidingViewController.new;
    KKFindViewController    *findVC    = KKFindViewController.new;
    KKProfileViewController *profileVC = KKProfileViewController.new;
    return @[homeVC,tidingsVC,findVC,profileVC];
}
- (NSArray *)tabBarAttributes {

    NSBundle *bundle = [NSBundle bundleForClass:[KKTabBarController class]];
    NSDictionary *homeAttributes = @{
                                     CYLTabBarItemTitle : @"首页",
                                     CYLTabBarItemImage:[UIImage imageNamed:@"home_normal.png"],
                                     CYLTabBarItemSelectedImage:[UIImage imageNamed:@"home_highlight.png"],
                                     CYLTabBarLottieURL : [NSURL fileURLWithPath:[bundle pathForResource:@"tab_home_animate" ofType:@"json"]]
                                     };

    NSDictionary *tidingsAttributes = @{
                                        CYLTabBarItemTitle : @"消息",
                                        CYLTabBarItemImage:[UIImage imageNamed:@"message_normal.png"],
                                        CYLTabBarItemSelectedImage:[UIImage imageNamed:@"message_highlight.png"],
                                        CYLTabBarLottieURL : [NSURL fileURLWithPath:[bundle pathForResource:@"tab_search_animate" ofType:@"json"]]
                                        };
    
    NSDictionary *findAttributes = @{
                                     CYLTabBarItemTitle : @"发现",
                                     CYLTabBarItemImage:[UIImage imageNamed:@"fishpond_normal.png"],
                                     CYLTabBarItemSelectedImage:[UIImage imageNamed:@"fishpond_highlight.png"],
                                     CYLTabBarLottieURL : [NSURL fileURLWithPath:[bundle pathForResource:@"tab_message_animate" ofType:@"json"]]
                                     };
    NSDictionary *profileAttributes = @{
                                        CYLTabBarItemTitle : @"我的",
                                        CYLTabBarItemImage:[UIImage imageNamed:@"account_normal.png"],
                                        CYLTabBarItemSelectedImage:[UIImage imageNamed:@"account_normal.png"],
                                        CYLTabBarLottieURL : [NSURL fileURLWithPath:[bundle pathForResource:@"tab_me_animate" ofType:@"json"]]
                                        };
    
    return @[homeAttributes,tidingsAttributes,findAttributes,profileAttributes];
}


- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //        tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    [tabBarController rootWindow].backgroundColor = [UIColor whiteColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor] ;
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] =  [UIColor blackColor] ;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    //     [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:UIColor.whiteColor];
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    //        [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
