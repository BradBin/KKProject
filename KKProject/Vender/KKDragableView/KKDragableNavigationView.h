//
//  KKDragableNavigationView.h
//  KKProject
//
//  Created by 尤彬 on 2019/7/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDragableView.h"

NS_ASSUME_NONNULL_BEGIN

@class KKDragableHeaderView;
@interface KKDragableNavigationView : KKDragableView
@property (nonatomic,strong,readonly) KKDragableHeaderView *navigationBar;
@property (nonatomic,assign) BOOL    navigationBarHidden;
@property (nonatomic,assign) CGFloat navigationBarOffsetY;
@property (nonatomic,assign) CGFloat navigationBarheight;

@end



static inline CGFloat KKDragableStatusBarHeight(){
    return KKSafeAreaInsets().bottom ? 44.0f : 20.0f;
}

static inline CGFloat KKDragableHeaderHeight(){
    return KKSafeAreaInsets().bottom ? 88.0f : 64.0f;
}

typedef NS_ENUM(NSUInteger, KKDragableBackType) {
    KKDragableBackTypeDefault = 0,
    KKDragableBackTypeWhite,
};
@interface KKDragableHeaderView : UIView
@property (nonatomic,assign) KKDragableBackType   backType;
@property (nonatomic,strong) UIButton            *leftButton;
@property (nonatomic,strong) UIButton            *rightButton;
@property (nonatomic,strong) UIView              *titleView;
@property (nonatomic,strong) YYAnimatedImageView *bottomLineView;

@property(nonatomic,assign) CGFloat              contentOffsetY;
@property (nonatomic,  copy,nullable) NSString            *title;

@end



typedef NS_ENUM(NSUInteger,KKDragableAuthorType) {
    KKDragableAuthorTypeDefault = 0,
    KKDragableAuthorTypeDetail
};
@interface KKDragableAuthorView : UIView
@property (nonatomic,strong) YYAnimatedImageView *avatorImgV;
@property (nonatomic,strong) YYLabel             *nameLabel;
@property (nonatomic,strong) YYLabel             *detailLabel;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+(instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithType:(KKDragableAuthorType)type;

@end


@interface KKDragableHeaderDetailView : UIView
@property (nonatomic,strong) KKDragableAuthorView *authorView;
@property (nonatomic,  copy) NSString *title;
@property (nonatomic,  copy) void(^ajustHeight)(CGFloat height);

@end





typedef NS_ENUM(NSUInteger,KKBottomBarType) {
    KKBottomBarTypeNewsDetailComment = 0,
    KKBottomBarTypePictureComment
};
@interface KKDragableBottomBarView : UIView

@property (nonatomic,assign) NSUInteger commentCount;
@property (nonatomic,assign,readonly) BOOL isDigg;//是否已经点赞
@property (nonatomic,assign,readonly) KKBottomBarType type;
@property (nonatomic,strong,readonly) YYTextView *textView;
@property (nonatomic,strong,readonly) UIView *splitView;
@property (nonatomic,assign,readonly) CGFloat offsetY;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithBarType:(KKBottomBarType)type;

@end

NS_ASSUME_NONNULL_END
