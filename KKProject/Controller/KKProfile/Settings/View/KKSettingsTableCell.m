//
//  KKSettingsTableCell.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKSettingsTableCell.h"


@interface KKRightTableCell ()

@end

@implementation KKRightTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)kk_setupView{
    [super kk_setupView];
    
    self.leftImagV = ({
        YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV;
    });
    
    self.titlelabel = ({
        YYLabel *label = YYLabel.new;
        [label setContentCompressionResistancePriority:50 forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.superview.mas_left).offset(CGFloatPixelRound(14)).priorityLow();
            make.centerY.equalTo(label.superview.mas_centerY);
        }];
        label;
    });
}

-(void)kk_showArrow:(BOOL)isShow{
    if (isShow) {
        self.accessoryView = ({
            YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
            imgV.backgroundColor = UIColor.redColor;
            imgV.contentMode = UIViewContentModeScaleAspectFit;
            imgV.size = CGSizeMake(CGFloatPixelRound(6), CGFloatPixelRound(11.0f));
            imgV;
        });
    }else{
        self.accessoryView = nil;
    }
}

-(void)setRightView:(UIView *)rightView{
    if (_rightView) {
        [_rightView removeFromSuperview];
    }
    _rightView = rightView;
    if (rightView == nil) {
        return;
    }
    [self.contentView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightView.superview.mas_right).offset(-CGFloatPixelRound(11));
        make.height.equalTo(rightView.superview.mas_height);
        make.centerY.equalTo(rightView.superview.mas_centerY);
        make.left.mas_greaterThanOrEqualTo(self.titlelabel.mas_right).offset(CGFloatPixelRound(8));
    }];
}

-(void)kk_setImage:(UIImage *)image title:(NSString *)title{
    if (image) {
        [self.contentView addSubview:self.leftImagV];
        [self.leftImagV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImagV.superview.mas_left).offset(CGFloatPixelRound(16));
            make.centerY.equalTo(self.leftImagV.superview.mas_centerY);
            make.right.equalTo(self.titlelabel.mas_left).inset(CGFloatPixelRound(11)).priorityHigh();
            make.size.mas_equalTo([self kk_imageViewSize]);
        }];
        self.leftImagV.image = image;
    }else{
        if (self.leftImagV.superview) {
            [self.leftImagV removeFromSuperview];
        }
    }
    self.titlelabel.text = title;
}

- (CGSize)kk_imageViewSize{
    return CGSizeMake(CGFloatPixelRound(20.0f), CGFloatPixelRound(20.0f));
}

@end







@implementation KKContentTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)kk_setupView{
    [super kk_setupView];
    
    self.sublabel = ({
        YYLabel *label = YYLabel.new;
        label;
    });
    
    self.rightView = self.sublabel;
}

-(void)kk_setTitle:(NSString *)title subTitle:(NSString *)subtitle{
    [self kk_setImg:nil title:title subTitle:subtitle];
}

- (void)kk_setImg:(UIImage *)image title:(NSString *)title subTitle:(NSString *)subtitle{
    [super kk_setImage:image title:title];
    self.sublabel.text = subtitle;
}

@end



@implementation KKTextFieldTableCell



@end
