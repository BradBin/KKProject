//
//  KKAboutusHeader.m
//  KKProject
//
//  Created by youbin on 2019/11/24.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKAboutusHeader.h"
#import "KKAboutusViewModel.h"

#warning mark -崩溃 main()
static inline UIEdgeInsets KKSafeArea(){
    UIEdgeInsets safeArea;
    if (@available(iOS 13.0,*)) {
        safeArea = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets;
    }else if(@available(iOS 11.0,*)){
        safeArea = UIApplication.sharedApplication.keyWindow.safeAreaInsets;
    }else{
        safeArea = UIEdgeInsetsZero;
    }
    return safeArea;
}

static inline CGFloat KKNavContentHeight(){
    return CGFloatPixelRound(44);
}
static inline CGFloat KKNavBarHeight(){
    return KKSafeArea().top > 0 ? CGFloatPixelRound(88) : CGFloatPixelRound(64);
}

static inline UIWindow* KKWindow(){
    UIWindow *window = nil;
    if (@available(iOS 13.0,*)) {
        window = UIApplication.sharedApplication.windows.firstObject;
    }else{
        window = UIApplication.sharedApplication.keyWindow;
    }
    return window;
}

@interface KKAboutusHeader ()

@property (nonatomic, strong) KKAboutusViewModel *viewModel;
@property (nonatomic, strong) KKView *navBarView;

@end

@implementation KKAboutusHeader

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    _viewModel = viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)kk_setupView{
    [super kk_setupView];
    self.navBarView = ({
        KKView *view = KKView.new;
        view.hidden = true;
        view.backgroundColor = UIColor.whiteColor;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view.superview.mas_bottom);
            make.centerX.equalTo(view.superview.mas_centerX);
            make.width.equalTo(view.superview.mas_width);
            make.height.mas_equalTo(KKNavBarHeight());
        }];
        view;
    });
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height - KKSafeArea().top, 0, 0, 0);
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGPoint newOffset = [change[@"new"] CGPointValue];
    [self updateSubViewsWithScrollOffset:newOffset];
}

- (void)updateSubViewsWithScrollOffset:(CGPoint)newOffset{
   
    CGFloat destinaOffset     = -KKNavContentHeight();
    CGFloat startChangeOffset = -self.scrollView.contentInset.top;
    newOffset.y  = newOffset.y>destinaOffset ? destinaOffset : newOffset.y;
    newOffset.y  = newOffset.y<startChangeOffset ? startChangeOffset : newOffset.y;
    newOffset    = CGPointMake(newOffset.x, newOffset.y);
    CGFloat newY = -newOffset.y-self.scrollView.contentInset.top;
    
    if (newOffset.y == destinaOffset) {
        self.navBarView.hidden = false;
    }else{
        self.navBarView.hidden = true;
    }
     NSLog(@"offset.y: %lf %lf",newOffset.y,newY);
    
    self.frame = CGRectMake(0, newY, self.frame.size.width, self.frame.size.height);
}


-(void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
