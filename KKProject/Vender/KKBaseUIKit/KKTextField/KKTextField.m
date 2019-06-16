//
//  KKTextField.m
//  KKForeignTeacher
//
//  Created by 尤彬 on 2018/11/19.
//  Copyright © 2018 youbin. All rights reserved.
//

#import "KKTextField.h"

static CGFloat kk_textContainerMargin = 12.0f;

@implementation KKTextField


-(void)setTextContainerMargin:(CGFloat)textContainerMargin{
    
    _textContainerMargin = textContainerMargin;
}



//控制 placeHolder 的位置，默认距离: 12
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds ,
                       self.textContainerMargin >= kk_textContainerMargin ? self.textContainerMargin : kk_textContainerMargin ,
                       0 );
}

// 控制文本的位置，左右缩 默认距离: 12
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds ,
                       self.textContainerMargin >= kk_textContainerMargin ? self.textContainerMargin : kk_textContainerMargin ,
                       0 );
}

//placeholder起始位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds ,
                       self.textContainerMargin >= kk_textContainerMargin ? self.textContainerMargin : kk_textContainerMargin ,
                       0 );
}




@end




#pragma mark -
#pragma mark - KKTextFieldView
@interface KKTextFieldView ()
@property (nonatomic,strong) CALayer *bottomLayer;

@end

@implementation KKTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textfield = [[KKTextField alloc] init];
        [self addSubview:_textfield];
        _bottomLayer = CALayer.layer;
        _bottomLayer.backgroundColor = [UIColor colorWithWhite:0.75 alpha:0.5].CGColor;
        [self.layer addSublayer:_bottomLayer];
    }
    return self;
}

-(void)setBottomlineColor:(UIColor *)bottomlineColor{
    if (bottomlineColor) {
        _bottomLayer.backgroundColor = bottomlineColor.CGColor;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width          = CGRectGetWidth(self.frame);
    CGFloat height         = CGRectGetHeight(self.frame);
    CGFloat lineHeight     = CGFloatPixelRound(0.8);
    self.textfield.frame   = CGRectMake(0, 0, width, height - lineHeight);
    self.bottomLayer.frame = CGRectMake(0, height - lineHeight, width, lineHeight);
}
@end
