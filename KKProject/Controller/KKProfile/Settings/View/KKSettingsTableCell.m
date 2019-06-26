//
//  KKSettingsTableCell.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKSettingsTableCell.h"

static inline CGFloat KKCellMargin(){
    return CGFloatPixelRound(16.0f);
}

static inline CGFloat KKCellContentMargin(){
    return CGFloatPixelRound(8.0f);
}

@interface KKSettingsTableCell()

@end

@implementation KKSettingsTableCell

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
        YYLabel *label  = YYLabel.new;
        label.textColor = [UIColor colorWithHexString:@"#1B1B1B"];
        label.font      = [UIFont systemFontOfSize:15.5f];
        [label setContentCompressionResistancePriority:50 forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.superview.mas_left).offset(KKCellMargin()).priorityHigh();
            make.centerY.equalTo(label.superview.mas_centerY);
        }];
        label;
    });
}

-(void)kk_showArrow:(BOOL)isShow{
    if (isShow) {
        self.accessoryView = ({
            YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
            imgV.image                = [[UIImage imageNamed:@"cell_arrow_right.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            imgV.contentMode          = UIViewContentModeScaleAspectFit;
            imgV.size                 = CGSizeMake(CGFloatPixelRound(15), CGFloatPixelRound(15));
            imgV;
        });
    }else{
        self.accessoryView = nil;
    }
    
    CGFloat rightMargin = isShow? KKCellContentMargin() : KKCellMargin();
    [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightView.superview.mas_right).offset(-CGFloatPixelRound(rightMargin));
    }];
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
        make.right.equalTo(rightView.superview.mas_right).offset(-KKCellContentMargin());
        make.height.mas_greaterThanOrEqualTo(@0);
        make.height.mas_lessThanOrEqualTo(rightView.superview.mas_height);
        make.centerY.equalTo(rightView.superview.mas_centerY);
        make.left.mas_greaterThanOrEqualTo(self.titlelabel.mas_right).offset(KKCellContentMargin());
        make.left.mas_greaterThanOrEqualTo(rightView.superview.mas_centerX);
    }];
}

-(void)kk_setImage:(UIImage *)image title:(NSString *)title{
    if (image) {
        [self.contentView addSubview:self.leftImagV];
        [self.leftImagV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImagV.superview.mas_left).offset(KKCellMargin()).priorityHigh();
            make.centerY.equalTo(self.leftImagV.superview.mas_centerY);
            make.right.equalTo(self.titlelabel.mas_left).inset(KKCellContentMargin()).priorityHigh();
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
    return CGSizeMake(CGFloatPixelRound(20), CGFloatPixelRound(20));
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
        YYLabel *label      = YYLabel.new;
        label.font          = [UIFont systemFontOfSize:13.5f];
        label.textColor     = [UIColor colorWithHexString:@"#5B5B5B"];
        label.textAlignment = NSTextAlignmentRight;
        label.numberOfLines = 2;
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

-(void)kk_setupView{
    [super kk_setupView];
    self.textfield = ({
        UITextField *textfield    = UITextField.alloc.init;
        textfield.textAlignment   = NSTextAlignmentRight;
        textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textfield addTarget:self action:@selector(textfieldChange:) forControlEvents:UIControlEventEditingChanged];
        textfield;
    });
    self.rightView = self.textfield;
}

-(void)setRightView:(UIView *)rightView{
    [super setRightView:rightView];
    [rightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titlelabel.mas_right).offset(KKCellContentMargin());
    }];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (void)textfieldChange:(KKTextField *)textfield{}

@end
