//
//  KKHomeViewCell.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/19.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeViewCell.h"

NSString * const KKHomeViewCellIdentifier = @"KK.Home.Page.TableCell.Identifier";

@interface KKHomeViewCell ()
@property (nonatomic,strong) YYLabel *titlelabel;
@property (nonatomic,strong) YYAnimatedImageView *previewImgV;

@end

@implementation KKHomeViewCell

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
    
    self.titlelabel = ({
        YYLabel *label = [self createLabelWithHidden:false textLayout:false];
        [self.contentView addSubview:label];
        label;
    });
    
    
}

- (void)setLayout:(KKHomeLayout *)layout{
    _layout = layout;
}

@end
