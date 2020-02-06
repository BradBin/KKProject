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

@interface KKTabBarController ()<UITabBarControllerDelegate,
CYLTabBarControllerDelegate>

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
    self.delegate = self;
    
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
    
    [tabBarController rootWindow].backgroundColor = [UIColor whiteColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性

    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor redColor] ;
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] =  [UIColor orangeColor] ;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    

    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:UIColor.clearColor]];
    [[UITabBar appearance] setBackgroundColor:UIColor.whiteColor];
 
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:UIColor.clearColor]];
    [[UITabBar appearance] setTranslucent:false];

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
