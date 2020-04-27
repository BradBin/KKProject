//
//  KKTableViewCell.m
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/10/25.
//  Copyright © 2018 youbin. All rights reserved.
//

#import "KKTableViewCell.h"

@implementation KKTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.backgroundView removeFromSuperview];
        [self kk_setupView];
        [self kk_bindViewModel];
    }
    return self;
}

-(void)kk_setupView{}

-(void)kk_bindViewModel{}


/**
 创建YYLabel实例对象
 
 @param hidden 显示/隐藏
 @param textLayout 是否忽略除textLayout以外的属性 true:是 false:不忽略
 @return 实例对象
 */
- (YYLabel *) createLabelWithHidden:(BOOL) hidden textLayout:(BOOL) textLayout{
    YYLabel *label = YYLabel.alloc.init;
    label.displaysAsynchronously = false;
    label.ignoreCommonProperties = textLayout;
    label.fadeOnAsynchronouslyDisplay = false;
    label.fadeOnHighlight        = false;
    label.lineBreakMode          = NSLineBreakByTruncatingTail;
    label.textContainerInset     = UIEdgeInsetsMake(2, 2, 2, 2);
    label.hidden                 = hidden;
    return label;
}


-(UIImageView *)setImageWithURL:(NSURL *)url imageView:(UIImageView *)imageView{
    @weakify(imageView);
    [imageView setImageWithURL:url placeholder:[UIImage imageWithColor:[UIColor colorWithHexString:@"#EFEFEF"]] options:YYWebImageOptionProgressiveBlur progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify(imageView);
        if (imageView == nil) return;
        if (image && stage == YYWebImageStageFinished) {
            ((YYAnimatedImageView *)imageView).image = image;
            if (from != YYWebImageFromMemoryCacheFast) {
                CATransition *transition = [CATransition animation];
                transition.duration = 0.15;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                transition.type = kCATransitionFade;
                [imageView.layer addAnimation:transition forKey:@"contents"];
            }
        }
    }];
    return imageView;
}


@end
