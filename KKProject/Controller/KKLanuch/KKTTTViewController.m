//
//  KKTTTViewController.m
//  KKProject
//
//  Created by youbin on 2020/3/1.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTTTViewController.h"
#import <TTTPlayerKit/TTTPlayerKit.h>
#import <TTTRtcEngineVoiceKit/TTTRtcEngineVoiceKit.h>

#define kTTTKitAppId   @"54bfbf3c4c0dac6f948320dbf7c7de8e"

@interface KKTTTViewController ()<TTTRtcEngineDelegate>

@property (nonatomic, strong) TTTRtcEngineKit *rtcKit;
@property (nonatomic, strong) UIButton *mixAudioButton;

@end

@implementation KKTTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)kk_layoutNavigation{
    [super kk_layoutNavigation];
    self.kk_navigationBar.hidden = true;
}

-(void)kk_addSubviews{
    [super kk_addSubviews];
    self.mixAudioButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = UIColor.redColor;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.superview.mas_centerX);
            make.centerY.equalTo(button.superview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        button;
    });
}

-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    self.rtcKit = [TTTRtcEngineKit sharedEngineWithAppId:kTTTKitAppId delegate:self];
    //设置频道模式
    [self.rtcKit setChannelProfile:TTTRtc_ChannelProfile_Communication];
    [self.rtcKit enableAudioVolumeIndication:1000 smooth:3];
    [self.rtcKit adjustPlaybackSignalVolume:200];
    [self.rtcKit muteLocalAudioStream:false];
    
    @weakify(self);
    [[self.mixAudioButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        x.selected = !x.selected;
        if (x.selected) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Life" ofType:@"mp3"];
            [self.rtcKit startAudioMixing:path loopback:false cycle:1];
        }else{
            [self.rtcKit stopAudioMixing];
        }
    }];
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
