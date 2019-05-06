//
//  KKCollectionView.m
//  ot-dayu
//
//  Created by 尤彬 on 2019/3/1.
//  Copyright © 2019 YangCK. All rights reserved.
//

#import "KKCollectionView.h"
#import "AppDelegate.h"

@implementation KKCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    return  [super init];
}

- (void) commitInit{
    
    [self _kk_commitInit];
    [self kk_setupView];
    [self kk_setupConfig];
    [self kk_bindViewModel];
}

-(void)kk_bindViewModel{}

- (void)kk_setupView{}

- (void)kk_setupConfig{}

-(void)kk_addReturnKeyBoard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapAction)];
    tap.numberOfTapsRequired    = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void) tapAction{
    AppDelegate *app = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [app.window endEditing:true];
}

- (void) _kk_commitInit{
    self.loading = false;
    self.collectionView = ({
        UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.alloc.init;
        flowLayout.minimumLineSpacing      = 0.0f;
        flowLayout.minimumInteritemSpacing = 0.0f;
        _KKCollectionView *collectionView  = [[_KKCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate   = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor  = UIColor.whiteColor;
        [self addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(collectionView.superview);
        }];
        [collectionView.superview layoutIfNeeded];
        collectionView;
    });
}


#pragma mark -
#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return UICollectionViewCell.new;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeZero;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



@implementation _KKCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delaysContentTouches = NO;
        self.canCancelContentTouches = YES;
        // Remove touch delay (since iOS 8)
        UIView *wrapView = self.subviews.firstObject;
        // UITableViewWrapperView
        if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
            for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
                // UIScrollViewDelayedTouchesBeganGestureRecognizer
                if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
                    gesture.enabled = NO;
                    break;
                }
            }
        }
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
