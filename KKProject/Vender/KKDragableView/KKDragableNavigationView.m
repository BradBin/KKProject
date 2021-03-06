//
//  KKDragableNavigationView.m
//  KKProject
//
//  Created by 尤彬 on 2019/7/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKDragableNavigationView.h"


@interface KKDragableNavigationView()
@property (nonatomic,strong) KKDragableHeaderView *navigationBar;

@end

@implementation KKDragableNavigationView

- (void)setupView{
    [super setupView];
    
    self.topSpace = 0.0f;
    self.navigationBarOffsetY = KKDragableStatusBarHeight() * 0.5;
    self.navigationBarheight  = KKDragableHeaderHeight();
    
    self.navigationBar = ({
        KKDragableHeaderView *view = KKDragableHeaderView.alloc.init;
        view.backType              = KKDragableBackTypeDefault;
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(KKDragableHeaderHeight());
        }];
        view;
    });
}

-(void)viewWillAppear{
    [super viewWillAppear];
}

-(void)viewDidAppear{
    [super viewDidAppear];
}

-(void)viewWillDisappear{
    [super viewWillDisappear];
}

-(void)viewDidDisappear{
    [super viewDidDisappear];
}



#pragma mark -
#pragma mark - setter
-(void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    _navigationBarHidden = navigationBarHidden;
    [self.navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(navigationBarHidden ? 0.0f : self.navigationBarheight);
    }];
}

-(void)setNavigationBarOffsetY:(CGFloat)navigationBarOffsetY{
    _navigationBarOffsetY = navigationBarOffsetY;
    self.navigationBar.contentOffsetY = navigationBarOffsetY;
}

-(void)setNavigationBarheight:(CGFloat)navigationBarheight{
    _navigationBarheight = navigationBarheight;
    [self.navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(navigationBarheight);
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end







#pragma mark -
#pragma mark - KKDragableHeaderView
@interface KKDragableHeaderView()
@property (nonatomic,strong) UIView *navigationBarView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation KKDragableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self bindViewModel];
    }
    return self;
}

- (void)setupView{
    self.bottomLineView = ({
        YYAnimatedImageView *view = YYAnimatedImageView.alloc.init;
        view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view.superview.mas_bottom);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(CGFloatPixelRound(0.5));
        }];
        view;
    });
    
    self.navigationBarView = ({
        UIView *view = UIView.alloc.init;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottomLineView.mas_top);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(CGFloatPixelRound(44.0f));
        }];
        view;
    });
    
    self.leftButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:KKDragableImage(@"btn_back_black.png") forState:UIControlStateNormal];
        [self.navigationBarView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.superview.mas_left).offset(CGFloatPixelRound(8));
            make.centerY.equalTo(button.superview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(CGFloatPixelRound(30.0f), CGFloatPixelRound(44.0f))).priorityHigh();
        }];
        button;
    });
    
    self.rightButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.navigationBarView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(button.superview.mas_right).offset(-CGFloatPixelRound(12)).priorityHigh();
            make.centerY.equalTo(button.superview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(CGFloatPixelRound(44.0f), CGFloatPixelRound(44.0f)));
        }];
        button;
    });
    
    self.titleLabel = ({
        UILabel *label = UILabel.new;
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
}

- (void)bindViewModel{
    
}

-(void)setTitle:(NSString *)title{
    if (title.isNotBlank) {
        self.titleLabel.text = title;
        [self.navigationBarView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel.superview.mas_centerY);
            make.height.equalTo(self.titleLabel.superview.mas_height);
            make.left.equalTo(self.leftButton.mas_right);
            make.right.equalTo(self.rightButton.mas_left);
        }];
    }else{
        if (self.titleLabel.superview) {
            [self.titleLabel removeFromSuperview];
        }
    }
}

-(void)setTitleView:(UIView *)titleView{
    if (_titleView) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    if (titleView == nil) {
        return;
    }
    [self.navigationBarView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleView.superview.mas_centerY);
        make.height.equalTo(titleView.superview.mas_height);
        make.left.equalTo(self.leftButton.mas_right);
        make.right.equalTo(self.rightButton.mas_left).priority(UILayoutPriorityRequired);
    }];
}


-(void)setBackType:(KKDragableBackType)backType{
    UIImage *backImage = backType == KKDragableBackTypeDefault?
    KKDragableImage(@"btn_back_black.png"):
    KKDragableImage(@"btn_back_white.png");
    [self.leftButton setImage:backImage forState:UIControlStateNormal];
}

@end




#pragma mark -
#pragma mark - KKDragableAuthorView
@interface KKDragableAuthorView ()
@property (nonatomic,assign) KKDragableAuthorType type;
@property (nonatomic,strong) UIButton *followBtn;

@end

@implementation KKDragableAuthorView

- (instancetype)initWithType:(KKDragableAuthorType)type{
    self = [super init];
    if (self) {
        _type = type;
        [self setupView];
        [self bindViewModel];
    }
    return self;
}

- (void)setupView{
    
    self.avatorImgV = ({
        YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
        imgV.contentMode          = UIViewContentModeScaleAspectFill;
        imgV.clipsToBounds        = true;
        imgV.layer.borderWidth    = CGFloatPixelRound(0.8);
        imgV.layer.borderColor    = [[UIColor colorWithHexString:@"#EFEFEF"] CGColor];
        imgV;
    });
    
    self.followBtn = ({
        UIButton *button           = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.masksToBounds = true;
        button.layer.cornerRadius  = CGFloatPixelRound(5.0f);
        button.titleLabel.font     = KKDefaultFont();
        [button setTitle:@"关注"   forState:UIControlStateNormal];
        [button setTitle:@"已关注" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor]     forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:UIColor.redColor]   forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateSelected];
        button;
    });
    
    self.nameLabel = ({
        YYLabel *label      = YYLabel.new;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.font          = KKDefaultTitleFont();
        label.textColor     = KKDefaultTitleColor();
        label;
    });
    
    self.detailLabel = ({
        YYLabel *label      = YYLabel.new;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.font          = KKDefaultDescFont();
        label.textColor     = KKDefaultDescColor();
        label;
    });
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 16, 0, -16);
    switch (self.type) {
        case KKDragableAuthorTypeDefault:
        {
        [self addSubview:self.avatorImgV];
        [self addSubview:self.nameLabel];
        [self addSubview:self.followBtn];
        
        [self.avatorImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatorImgV.superview.mas_top).offset(insets.top);
            make.left.equalTo(self.avatorImgV.superview.mas_left).offset(insets.left).priority(995);
            make.bottom.lessThanOrEqualTo(self.avatorImgV.superview.mas_bottom).offset(insets.bottom);
            make.width.equalTo(self.avatorImgV.mas_height).priority(995);
            make.height.mas_lessThanOrEqualTo(CGFloatPixelRound(80.0f));
        }];
        
        [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.followBtn.superview.mas_centerY);
            make.right.equalTo(self.followBtn.superview.mas_right).offset(insets.right);
            make.width.mas_greaterThanOrEqualTo(CGFloatPixelRound(50));
            make.width.mas_lessThanOrEqualTo(CGFloatPixelRound(75)).priority(995);
            make.height.mas_equalTo(CGFloatPixelRound(25)).priority(995);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.superview.mas_centerY);
            make.height.equalTo(self.nameLabel.superview.mas_height);
            make.left.equalTo(self.avatorImgV.mas_right).offset(insets.left * 0.5);
            make.right.mas_lessThanOrEqualTo(self.followBtn.mas_left).offset(insets.right);
        }];
        } break;
            
        case KKDragableAuthorTypeDetail:
        {
        [self addSubview:self.avatorImgV];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.followBtn];
        [self.avatorImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatorImgV.superview.mas_top).offset(insets.top);
            make.left.equalTo(self.avatorImgV.superview.mas_left).offset(insets.left).priority(995);
            make.bottom.lessThanOrEqualTo(self.avatorImgV.superview.mas_bottom).offset(insets.bottom);
            make.width.equalTo(self.avatorImgV.mas_height);
            make.height.width.mas_lessThanOrEqualTo(CGFloatPixelRound(80.0f));
        }];
        
        [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.followBtn.superview.mas_centerY);
            make.right.equalTo(self.followBtn.superview.mas_right).offset(insets.right);
            make.width.mas_greaterThanOrEqualTo(CGFloatPixelRound(50));
            make.width.mas_lessThanOrEqualTo(CGFloatPixelRound(75)).priority(995);
            make.height.mas_equalTo(CGFloatPixelRound(25)).priority(995);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.superview.mas_top);
            make.left.equalTo(self.avatorImgV.mas_right).offset(insets.left * 0.5);
            make.right.mas_lessThanOrEqualTo(self.followBtn.mas_left).offset(insets.right);
            make.height.mas_greaterThanOrEqualTo(@0);
        }];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(4.0f);
            make.bottom.equalTo(self.detailLabel.superview.mas_bottom);
            make.left.equalTo(self.avatorImgV.mas_right).offset(insets.left * 0.5);
            make.right.mas_lessThanOrEqualTo(self.followBtn.mas_left).offset(insets.right);
            make.height.mas_greaterThanOrEqualTo(@0);
        }];
        
        [self.nameLabel setContentCompressionResistancePriority:MASLayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        [self.detailLabel setContentCompressionResistancePriority:MASLayoutPriorityDefaultMedium forAxis:UILayoutConstraintAxisVertical];
        
        } break;
            
        default:
            break;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.avatorImgV.layer.cornerRadius = CGRectGetHeight(self.avatorImgV.frame) * 0.5;
    //备注:YYLabel和masonryd组合使用时,自适应高度,需要提前设置preferredMaxLayoutWidth属性
    //否者不能换行显示
    self.nameLabel.preferredMaxLayoutWidth   = CGRectGetWidth(self.nameLabel.frame);
    self.detailLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.detailLabel.frame);
}

- (void)bindViewModel{
    
    NSURL *url = [NSURL URLWithString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2771317352,2552114169&fm=27&gp=0.jpg"];
    [self.avatorImgV setImageWithURL:url placeholder:[UIImage imageWithColor:UIColor.redColor] options:YYWebImageOptionProgressiveBlur progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        return image;
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    
    self.nameLabel.text   = @"fasdfadfasdfadfaffdfdfdfdfddfadsfadfa";
    self.detailLabel.text = @"作者vzxcvzxcvzx简介";
    
}


@end



#pragma mark -
#pragma mark - KKDragableHeaderDetailView

@interface KKDragableHeaderDetailView()
@property (nonatomic,strong) YYLabel *titleLabel;

@end

@implementation KKDragableHeaderDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //备注:YYLabel和masonryd组合使用时,自适应高度,需要提前设置preferredMaxLayoutWidth属性
    //否者不能换行显示
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
}

- (void)setupView{
    self.backgroundColor = UIColor.whiteColor;
    self.titleLabel = ({
        YYLabel *label           = YYLabel.new;
        label.textContainerInset = UIEdgeInsetsMake(8, 16, 8, 16);
        label.numberOfLines      = 0;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.superview.mas_top);
            make.left.equalTo(label.superview.mas_left);
            make.right.equalTo(label.superview.mas_right);
            make.height.mas_greaterThanOrEqualTo(@0);
        }];
        label;
    });
    
    self.authorView = ({
        KKDragableAuthorView *view = [[KKDragableAuthorView alloc] initWithType:KKDragableAuthorTypeDetail];
        [self addSubview:view];
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(CGFloatPixelRound(8.0f));
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(CGFloatPixelRound(60.0));
        }];
        view;
    });
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
    [self layoutIfNeeded];
    if (self.ajustHeight) {
        self.ajustHeight(self.authorView.bottom + CGFloatPixelRound(10));
    }
}

@end










#pragma mark -
#pragma mark - KKDragableBottomBarView

@interface KKDragableBottomBarView ()
@property (nonatomic,assign) KKBottomBarType type;
@property (nonatomic,strong) YYTextView *textView;
@property (nonatomic,strong) UIView     *splitView;
@property (nonatomic,strong) UIView     *commentView;
@property (nonatomic,strong) UIView     *favoriteView;
@property (nonatomic,strong) UIView     *diggView;
@property (nonatomic,strong) UIView     *shareView;
@property (nonatomic,strong) UIView     *inputView;

@end
@implementation KKDragableBottomBarView

- (instancetype)initWithBarType:(KKBottomBarType)type{
    self = [super init];
    if (self) {
        _type = type;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    [self addSubview:self.textView];
    [self addSubview:self.splitView];
    UIEdgeInsets insets = UIEdgeInsetsMake(8, 16, -5, -16);
    switch (self.type) {
        case KKBottomBarTypeNewsDetailComment:
        {
        [self addSubview:self.shareView];
        [self addSubview:self.favoriteView];
        [self addSubview:self.diggView];
        [self addSubview:self.commentView];
        
        [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareView.superview.mas_right).offset(insets.right).priorityHigh();
            make.centerY.equalTo(self.shareView.superview.mas_centerY);
            make.top.equalTo(self.shareView.superview.mas_top).offset(insets.top).priorityHigh();
            make.bottom.equalTo(self.shareView.superview.mas_bottom).offset(insets.bottom).priorityHigh();
            make.width.equalTo(self.shareView.mas_height);
        }];
        
        [self.favoriteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareView.mas_left).offset(insets.right * 2);
            make.centerY.equalTo(self.shareView.mas_centerY);
            make.height.equalTo(self.shareView.mas_height);
            make.width.equalTo(self.shareView.mas_width);
        }];
        
        [self.diggView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.favoriteView.mas_left).offset(insets.right * 2);
            make.centerY.equalTo(self.favoriteView.mas_centerY);
            make.height.equalTo(self.favoriteView.mas_height);
            make.width.equalTo(self.favoriteView.mas_width);
        }];
        
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.diggView.mas_left).offset(insets.right * 2);
            make.centerY.equalTo(self.diggView.mas_centerY);
            make.height.equalTo(self.diggView.mas_height);
            make.width.equalTo(self.diggView.mas_width);
        }];
        
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.commentView.mas_left).offset(insets.right * 2);
            make.left.equalTo(self.textView.superview.mas_left).offset(insets.left);
            make.top.equalTo(self.textView.superview.mas_top).offset(insets.top);
            make.bottom.equalTo(self.textView.superview.mas_bottom).offset(insets.bottom);
        }];
        
        } break;
        case KKBottomBarTypePictureComment:
        {
        [self addSubview:self.shareView];
        [self addSubview:self.diggView];
        [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareView.superview.mas_right).offset(insets.right).priorityHigh();
            make.centerY.equalTo(self.shareView.superview.mas_centerY);
            make.top.equalTo(self.shareView.superview.mas_top).offset(insets.top).priorityHigh();
            make.bottom.equalTo(self.shareView.superview.mas_bottom).offset(insets.bottom).priorityHigh();
            make.width.equalTo(self.shareView.mas_height);
        }];
        
        [self.diggView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareView.mas_left).offset(insets.right * 2);
            make.centerY.equalTo(self.shareView.mas_centerY);
            make.height.equalTo(self.shareView.mas_height);
            make.width.equalTo(self.shareView.mas_width);
        }];
        
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.diggView.mas_left).offset(insets.right * 2);
            make.left.equalTo(self.textView.superview.mas_left).offset(insets.left);
            make.top.equalTo(self.textView.superview.mas_top).offset(insets.top);
            make.bottom.equalTo(self.textView.superview.mas_bottom).offset(insets.bottom);
        }];
        } break;
            
        default:
            break;
    }
    
    [self.splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.splitView.superview.mas_top);
        make.centerX.equalTo(self.splitView.superview.mas_centerX);
        make.width.equalTo(self.splitView.superview.mas_width);
        make.height.mas_equalTo(CGFloatPixelRound(0.5));
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textView.layer.cornerRadius = CGRectGetHeight(self.textView.frame) * 0.5;
}

#pragma mark -
#pragma mark - getter
-(YYTextView *)textView{
    if (_textView == nil) {
        _textView = YYTextView.new;
        _textView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        _textView.scrollEnabled   = false;
        _textView.editable        = false;
        _textView.text            = @"写评论...";
        _textView.textColor       = [UIColor colorWithHexString:@"#5B5B5B"];
        _textView.textContainerInset    = UIEdgeInsetsMake(8, 10, 5, 10);
        _textView.layer.masksToBounds   = true;
        _textView.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return _textView;
}

-(UIView *)splitView{
    if (_splitView == nil) {
        _splitView = UIView.alloc.init;
        _splitView.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    }
    return _splitView;
}

-(UIView *)commentView{
    if (_commentView == nil) {
        _commentView = UIView.alloc.init;
        _commentView.backgroundColor = UIColor.magentaColor;
    }
    return _commentView;
}

-(UIView *)favoriteView{
    if (_favoriteView == nil) {
        _favoriteView = UIView.alloc.init;
        _favoriteView.backgroundColor = UIColor.brownColor;
    }
    return _favoriteView;
}

-(UIView *)diggView{
    if (_diggView == nil) {
        _diggView = UIView.alloc.init;
        _diggView.backgroundColor = UIColor.orangeColor;
    }
    return _diggView;
}

-(UIView *)shareView{
    if (_shareView == nil) {
        _shareView = UIView.alloc.init;
        _shareView.backgroundColor = UIColor.redColor;
    }
    return _shareView;
}

@end



