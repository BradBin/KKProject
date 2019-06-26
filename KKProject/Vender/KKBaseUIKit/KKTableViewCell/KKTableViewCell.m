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
        [self kk_setupConfigurate];
        [self kk_bindViewModel];
        [self kk_setupAccessoryView];
    }
    return self;
}

-(void)kk_bindViewModel{}

-(void)kk_setupConfigurate{};

-(void)kk_setupView{}

-(void)kk_setupAccessoryView{};

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

@end
