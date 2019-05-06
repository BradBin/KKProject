//
//  KKLoadingPlaceHolderView.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/2.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,KKLoadingPlaceHolderType) {
    KKLoadingPlaceHolderTypeLoading = 0,
    KKLoadingPlaceHolderTypeFailed = 1,
    
    KKLoadingPlaceHolderTypeBadNetwork = 9,
    KKLoadingPlaceHolderTypeBase = 99,
};

@interface KKLoadingPlaceHolderView : UIView
    
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *failedButton;
@property (nonatomic, assign) KKLoadingPlaceHolderType type;
    
- (void)kk_setRefreshCB:(void(^)(void))callBack;
    
- (void)kk_setPlaceHolderType:(KKLoadingPlaceHolderType)type withRefreshCB:(void(^)(void))callBack;

@end

NS_ASSUME_NONNULL_END
