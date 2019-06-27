//
//  KKRefreshGifHeader.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/27.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKRefreshGifHeader.h"


NSUInteger const kk_image_count = 16;
@interface KKRefreshGifHeader()
@property (nonatomic,strong) UILabel *label;

@end

@implementation KKRefreshGifHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    // 设置普通状态的动画图片
    self.mj_h = 50;
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i< kk_image_count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"KKRefresh.bundle/loading_%02ld.png",(long)i];
        UIImage *image = [UIImage imageNamed:imageName];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateIdle];
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    // 添加label
    self.label = ({
        UILabel *label      = UILabel.new;
        label.textColor     = UIColor.lightGrayColor;
        label.font          = [UIFont systemFontOfSize:10.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label;
    });
}
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.label.frame   = CGRectMake(0, self.mj_h - 15, self.mj_w, 15);
    self.gifView.frame = CGRectMake((self.mj_w - 25) / 2.0, 5, 25, 25);
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"下拉推荐";
            break;
        case MJRefreshStatePulling:
            self.label.text = @"松开推荐";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"推荐中";
            break;
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
