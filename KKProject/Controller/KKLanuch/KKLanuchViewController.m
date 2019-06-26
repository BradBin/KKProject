//
//  KKLanuchViewController.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKLanuchViewController.h"
#import "AppDelegate.h"


@interface KKLanuchViewController ()
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;
@property (nonatomic,strong) YYAnimatedImageView *backgroundImagView;

@end

@implementation KKLanuchViewController

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navigationBar.hidden = true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_addSubviews{
    [super kk_addSubviews];
    
    self.backgroundImagView = ({
        YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
        imgV.contentMode          = UIViewContentModeScaleAspectFill;
        [self.view addSubview:imgV];
        [self.view insertSubview:imgV atIndex:0];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imgV.superview);
        }];
        imgV;
    });
    
    self.loadingView = ({
        UIActivityIndicatorView *view = UIActivityIndicatorView.alloc.init;
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        view.color = [UIColor colorWithHexString:@"#207CB7"];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.superview.mas_centerX);
            make.centerY.equalTo(view.superview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        view;
    });
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    NSURL *url = [NSURL URLWithString:@"http://www.agri35.com/UploadFiles/img_2_995558030_1079414460_26.jpg"];
    @weakify(self)
    [self.backgroundImagView setImageWithURL:url
                                 placeholder:[UIImage imageNamed:@"placeHolder_avatar.png"]
                                     options:YYWebImageOptionProgressiveBlur | YYWebImageOptionAllowBackgroundTask
                                     manager:nil
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                        NSLog(@"图片下载进度:%lf",1.0f * receivedSize / expectedSize);
                                    } transform:nil
                                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                      @strongify(self);
                                      if (self.backgroundImagView == nil) return;
                                      if (image && stage == YYWebImageStageFinished) {
                                          ((YYAnimatedImageView *)self.backgroundImagView).image = image;
                                          if (from != YYWebImageFromMemoryCacheFast) {
                                              CATransition *transition = [CATransition animation];
                                              transition.duration = 0.15;
                                              transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                                              transition.type = kCATransitionFade;
                                              [self.backgroundImagView.layer addAnimation:transition forKey:@"contents"];
                                          }
                                      }
                                  }];

    [self.loadingView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingView stopAnimating];
        [KKErrorHelper kk_enterApp];
    });
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
