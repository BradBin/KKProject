//
//  KKView.m
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/10/25.
//  Copyright © 2018 youbin. All rights reserved.
//

#import "KKView.h"
#import "AppDelegate.h"

@implementation KKView



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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
