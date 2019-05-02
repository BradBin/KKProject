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
