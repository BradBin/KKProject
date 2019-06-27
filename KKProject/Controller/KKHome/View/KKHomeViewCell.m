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
    
    self.lineView = ({
        UIView *view = UIView.alloc.init;
        view.hidden  = true;
        view.left    = KKLayoutMargin();
        view.width   = KKLayoutContentWidth();
        view.height  = CGFloatPixelRound(0.8);
        view.backgroundColor = KKDefaultBackgroundViewColor();
        [self.contentView addSubview:view];
        view;
    });
    
    self.titlelabel = ({
        YYLabel *label = [self createLabelWithHidden:true textLayout:true];
        label.left     = KKLayoutMargin();
        label.width    = KKLayoutContentWidth();
        [self.contentView addSubview:label];
        label;
    });
    self.abstractlabel = ({
        YYLabel *label = [self createLabelWithHidden:true textLayout:true];
        label.left     = KKLayoutMargin();
        label.width    = KKLayoutContentWidth();
        [self.contentView addSubview:label];
        label;
    });
    
    self.authorlabel = ({
        YYLabel *label = [self createLabelWithHidden:true textLayout:true];
        label.left     = KKLayoutMargin();
        label.width    = KKLayoutContentWidth();
        [self.contentView addSubview:label];
        label;
    });
    
    self.previewImgV = ({
        YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
        imgV.contentMode          = UIViewContentModeScaleAspectFit;
        imgV.hidden               = true;
        [self.contentView addSubview:imgV];
        imgV;
    });

}

- (void)setLayout:(KKHomeLayout *)layout{
    _layout                 = layout;
    self.height             = layout.height;
    self.contentView.height = layout.height;
    CGFloat top             = layout.marginTop;
    
    if (layout.titleLayout.height) {
        self.titlelabel.top        = top;
        self.titlelabel.height     = layout.titleLayout.height;
        self.titlelabel.textLayout = layout.titleLayout.textLayout;
        self.titlelabel.hidden     = false;
        top += layout.titleLayout.height;
    }else{
        self.titlelabel.hidden     = true;
    }
    
    if (layout.abstractLayout.height) {
        self.abstractlabel.top        = top;
        self.abstractlabel.height     = layout.abstractLayout.height;
        self.abstractlabel.textLayout = layout.abstractLayout.textLayout;
        self.abstractlabel.hidden     = false;
        top += layout.abstractLayout.height;
    }else{
        self.abstractlabel.hidden     = true;
    }
    
    if (layout.authorLayout.height) {
        self.authorlabel.top        = top;
        self.authorlabel.height     = layout.authorLayout.height;
        self.authorlabel.textLayout = layout.authorLayout.textLayout;
        self.authorlabel.hidden     = false;
        top += layout.authorLayout.height;
    }else{
        self.authorlabel.hidden    = true;
    }
    
    if (layout.height) {
        self.lineView.top = layout.height - CGFloatPixelRound(0.8);
        self.lineView.hidden = false;
    }else{
        self.lineView.hidden = true;
    }
}

@end



NSString * const KKHomeViewImageCellIdentifier = @"KK.Home.View.Image.Cell.Identifier";
@implementation KKHomeViewImageCell

-(void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)kk_setupView{
    
}

-(void)setLayout:(KKHomeLayout *)layout{
    self.layout = layout;
    self.height = layout.height;
    self.contentView.height = layout.height;
    CGFloat top = layout.marginTop;
    
}

@end
