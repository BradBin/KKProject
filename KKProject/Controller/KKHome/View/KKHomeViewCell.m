//
//  KKHomeViewCell.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/19.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeViewCell.h"


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
    
    self.rightImgV = ({
        YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
        imgV.contentMode          = UIViewContentModeScaleAspectFill;
        imgV.layer.masksToBounds  = YES ;
        imgV.layer.borderWidth    = 0.5;
        imgV.layer.borderColor    = [[UIColor grayColor]colorWithAlphaComponent:0.1].CGColor;
        imgV.hidden               = true;
        [self.contentView addSubview:imgV];
        imgV;
    });

}


@end


NSString * const KKHomeViewTextCellIdentifier = @"KK.Home.View.Text.Cell.Identifier";
@implementation KKHomeViewTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setLayout:(KKHomeLayout *)layout{
    
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
    
    if (layout.authorLayout.height) {
        self.authorlabel.top        = top;
        self.authorlabel.height     = layout.authorLayout.height;
        self.authorlabel.textLayout = layout.authorLayout.textLayout;
        self.authorlabel.hidden     = false;
        top += layout.authorLayout.height;
    }else{
        self.authorlabel.hidden    = true;
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
    
    if (layout.height) {
        self.lineView.top = layout.height - CGFloatPixelRound(0.8);
        self.lineView.hidden = false;
    }else{
        self.lineView.hidden = true;
    }
}

@end


NSString * const KKHomeViewRightImageCellIdentifier = @"KK.Home.View.Right.Image.Cell.Identifier";
@implementation KKHomeViewImageCell

-(void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)kk_setupView{
    [super kk_setupView];
    
    self.leftImgV = ({
        YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
        imgV.contentMode          = UIViewContentModeScaleAspectFill;
        imgV.layer.masksToBounds  = YES ;
        imgV.layer.borderWidth    = 0.5;
        imgV.layer.borderColor    = [[UIColor grayColor]colorWithAlphaComponent:0.1].CGColor;
        imgV.hidden               = true;
        imgV.left                 = KKLayoutMargin();
        imgV.width                = KKLayoutContentImageWidth();
        [self.contentView addSubview:imgV];
        imgV;
    });
    
    self.midImgV = ({
        YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
        imgV.contentMode          = UIViewContentModeScaleAspectFill;
        imgV.layer.masksToBounds  = YES ;
        imgV.layer.borderWidth    = 0.5;
        imgV.layer.borderColor    = [[UIColor grayColor]colorWithAlphaComponent:0.1].CGColor;
        imgV.hidden               = true;
        imgV.left                 = self.leftImgV.right + KKLayoutMargin() * 0.25;
        imgV.width                = KKLayoutContentImageWidth();
        [self.contentView addSubview:imgV];
        imgV;
    });
    
    self.rightImgV.left  = self.midImgV.right + KKLayoutMargin() * 0.25;
    self.rightImgV.width = KKLayoutContentImageWidth();
    
}

-(void)setLayout:(KKHomeLayout *)layout{
   
    self.height             = layout.height;
    self.contentView.height = layout.height;
    CGFloat top             = layout.marginTop;
    
    if (layout.titleLayout.height) {
        self.titlelabel.top        = top;
        self.titlelabel.textLayout = layout.titleLayout.textLayout;
        self.titlelabel.height     = layout.titleLayout.height;
        self.titlelabel.hidden     = false;
        top += layout.titleLayout.height;
    }else{
        self.titlelabel.hidden     = true;
    }
    
    if (layout.pictureHeight) {
        self.leftImgV.top    = top;
        self.leftImgV.height = layout.pictureHeight;
        self.leftImgV.hidden = false;
        [self setImageWithURL:[layout.content.image_list[0] url] imageView:self.leftImgV];
        
        self.midImgV.top    = top;
        self.midImgV.height = layout.pictureHeight;
        self.midImgV.hidden = false;
        [self setImageWithURL:[layout.content.image_list[1] url] imageView:self.midImgV];

        self.rightImgV.top    = top;
        self.rightImgV.height = layout.pictureHeight;
        self.rightImgV.hidden = false;
        [self setImageWithURL:[layout.content.image_list[2] url] imageView:self.rightImgV];
        
        top += layout.pictureHeight;
    }else{
        self.leftImgV.hidden  = true;
        self.midImgV.hidden   = true;
        self.rightImgV.hidden = true;
    }
   
    if (layout.authorLayout.height) {
        self.authorlabel.top        = top;
        self.authorlabel.height     = layout.authorLayout.height;
        self.authorlabel.textLayout = layout.authorLayout.textLayout;
        self.authorlabel.hidden     = false;
        top += layout.authorLayout.height;
    }else{
        self.authorlabel.hidden     = true;
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

    if (layout.height) {
        self.lineView.top    = layout.height - CGFloatPixelRound(0.8);
        self.lineView.hidden = false;
    }else{
        self.lineView.hidden = true;
    }
}

@end






NSString * const KKHomeViewImageCellIdentifier = @"KK.Home.View.Image.Cell.Identifier";
@implementation KKHomeViewRightImageCell

-(void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)kk_setupView{
    [super kk_setupView];
    self.titlelabel.width  = KKLayoutContentWidth() - KKLayoutContentImageWidth();
    self.rightImgV.left  = self.titlelabel.right;
    self.rightImgV.width = KKLayoutContentImageWidth();
}

-(void)setLayout:(KKHomeLayout *)layout{
   
    self.height = layout.height;
    self.contentView.height = layout.height;
    CGFloat top = layout.marginTop;
    
    if (layout.titleLayout.height) {
        self.titlelabel.top        = top;
        self.titlelabel.textLayout = layout.titleLayout.textLayout;
        self.titlelabel.height     = layout.titleLayout.height;
        self.titlelabel.hidden     = false;
    }else{
        self.titlelabel.hidden     = true;
    }
    
    if (layout.content.has_image && layout.content.type == KKHomeDataFileTypeImage_Single) {
        if (layout.pictureHeight) {
            self.titlelabel.width    = KKLayoutContentWidth() - KKLayoutContentImageWidth();
            self.rightImgV.top     = top;
            self.rightImgV.left    = self.titlelabel.right;
            self.rightImgV.width   = KKLayoutContentImageWidth();
            self.rightImgV.height  = layout.pictureHeight;
            self.rightImgV.hidden  = false;
            [self setImageWithURL:layout.content.middle_image.url imageView:self.rightImgV];
        }else{
            self.rightImgV.hidden  = true;
        }
    }else{
        self.rightImgV.hidden  = true;
    }
    
    top += layout.titleLayout.height >= layout.pictureHeight? layout.titleLayout.height : layout.pictureHeight;
    if (layout.authorLayout.height) {
        self.authorlabel.top        = top;
        self.authorlabel.textLayout = layout.authorLayout.textLayout;
        self.authorlabel.height     = layout.authorLayout.height;
        self.authorlabel.hidden     = false;
        top += layout.authorLayout.height;
        
    }else{
        self.authorlabel.hidden = true;
    }
    
    if (layout.abstractLayout.height) {
        self.abstractlabel.top        = top;
        self.abstractlabel.textLayout = layout.abstractLayout.textLayout;
        self.abstractlabel.height     = layout.abstractLayout.height;
        self.abstractlabel.hidden     = false;
    }else{
        self.abstractlabel.hidden     = true;
    }
    
    if (layout.height) {
        self.lineView.top = layout.height - CGFloatPixelRound(0.8);
        self.lineView.hidden = false;
    }else{
        self.lineView.hidden = true;
    }
}

@end







NSString * const KKHomeViewVideoCellIdentifier = @"KK.Home.View.Video.Cell.Identifier";
@interface KKHomeViewVideoCell()
@property (nonatomic,strong) UIButton *playerBtn;

@end
@implementation KKHomeViewVideoCell

-(void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)kk_setupView{
    [super kk_setupView];

    self.coverImgV = ({
        YYAnimatedImageView *imgV = YYAnimatedImageView.alloc.init;
        imgV.contentMode          = UIViewContentModeScaleAspectFill;
        imgV.userInteractionEnabled = true;
        imgV.exclusiveTouch       = true;
        imgV.layer.masksToBounds  = YES ;
        imgV.layer.borderWidth    = 0.5;
        imgV.layer.borderColor    = [[UIColor grayColor]colorWithAlphaComponent:0.1].CGColor;
        imgV.hidden               = true;
        imgV.left                 = KKLayoutMargin();
        imgV.width                = KKLayoutContentWidth();
        [self.contentView addSubview:imgV];
        imgV;
    });
    
    self.playerBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.hidden    = true;
        [button setBackgroundImage:[UIImage imageNamed:@"video_player_44x44.png"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"video_player_44x44.png"] forState:UIControlStateNormal];
        [self.coverImgV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.superview.mas_centerX);
            make.centerY.equalTo(button.superview.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        button;
    });
}


-(void)kk_bindViewModel{
    [super kk_bindViewModel];
    @weakify(self);
    [[[self.playerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
 
        NSLog(@"---视频播放----");
    }];
}



- (void)setLayout:(KKHomeLayout *)layout{
    
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
    
    if (layout.videoHeight) {
        self.coverImgV.top    = top;
        self.coverImgV.height = layout.videoHeight;
        self.coverImgV.hidden = false;
        self.playerBtn.hidden = false;
        NSURL * coverImgURL;
        if (layout.content.large_image_list.count) {
            coverImgURL = layout.content.large_image_list.firstObject.url;
        }else{
            coverImgURL = layout.content.image_list.firstObject.url;
        }
        [self setImageWithURL:coverImgURL imageView:self.coverImgV];
        top += layout.videoHeight;
    }else{
        self.playerBtn.hidden = true;
        self.coverImgV.hidden = true;
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
    
    if (layout.abstractLayout.height) {
        self.abstractlabel.top        = top;
        self.abstractlabel.height     = layout.abstractLayout.height;
        self.abstractlabel.textLayout = layout.abstractLayout.textLayout;
        self.abstractlabel.hidden     = false;
        top += layout.abstractLayout.height;
    }else{
        self.abstractlabel.hidden     = true;
    }
    
    if (layout.height) {
        self.lineView.top = layout.height - CGFloatPixelRound(0.8);
        self.lineView.hidden = false;
    }else{
        self.lineView.hidden = true;
    }
}



@end
