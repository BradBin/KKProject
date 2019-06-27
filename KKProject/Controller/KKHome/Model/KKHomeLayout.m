//
//  KKHomeLayout.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKHomeLayout.h"


@implementation KKHomeLayout

+ (instancetype)kk_layoutWithModel:(KKHomeDataContentModel *)content{
    return [[self alloc] initWithModel:content];
}

- (instancetype)initWithModel:(KKHomeDataContentModel *)content
{
    self = [super init];
    if (self) {
        _content = content;
        [self kk_layout];
    }
    return self;
}

- (void)kk_layout{
    _height = 0.0f;
    [self kk_titleLayout];
    [self kk_abstractLayout];
    [self kk_authorLayout];
    
    if (_titleLayout.height)    _height += _titleLayout.height;
    if (_abstractLayout.height) _height += _abstractLayout.height;
    if (_authorLayout.height)   _height += _authorLayout.height;
    
    if (_height) {
        _height += self.marginTop;
        _height += self.marginBottom;
    }
}

- (void)kk_titleLayout{
    NSString *feedTitle = _content.feed_title;
    if (feedTitle.isNotBlank == false) return;
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:feedTitle];
    attrText.color                      = KKDefaultTitleColor();
    attrText.font                       = KKDefaultTitleFont();
    
    TextLayout *layout = [YYTextLinePositionModifier layoutWithAttributedString:attrText
                                                                        maxRows:0
                                                                     paddingTop:8
                                                                  paddingBottom:8
                                                                         insets:UIEdgeInsetsMake(8, 8, 8, 8)
                                                                    containSize:CGSizeMake(KKLayoutContentWidth(), MAXFLOAT)];
    _titleLayout = layout;
}

- (void)kk_abstractLayout{
    NSString *abstract = _content.abstract;
    if (abstract.isNotBlank == false) return;
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:abstract];
    attrText.color                      = KKDefaultDescColor();
    attrText.font                       = KKDefaultDescFont();
    
    TextLayout *layout = [YYTextLinePositionModifier layoutWithAttributedString:attrText
                                                                        maxRows:0
                                                                     paddingTop:8
                                                                  paddingBottom:8
                                                                         insets:UIEdgeInsetsMake(8, 8, 8, 8)
                                                                    containSize:CGSizeMake(KKLayoutContentWidth(), MAXFLOAT)];
    _abstractLayout = layout;
}


- (void)kk_authorLayout{
    
    NSMutableString *mString = NSMutableString.alloc.init;
    
    if (_content.user_info.name.isNotBlank) {
        [mString appendString:_content.user_info.name];
    }
    
    if (_content.comment_count.unsignedIntegerValue) {
        [mString appendFormat:@"  %@评论",_content.comment_count];
    }
    
    if (_content.publish_date) {
      NSString *publishDateString = [KKToolsHelper.shared timelineWithDate:_content.publish_date];
        if (publishDateString.isNotBlank) {
            [mString appendFormat:@"  %@",publishDateString];
        }
    }

    if (mString.isNotBlank == false) return;
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:mString];
    attrText.color                      = KKDefaultDescColor();
    attrText.font                       = KKDefaultFontSize(9.0f);
    
    TextLayout *layout = [YYTextLinePositionModifier layoutWithAttributedString:attrText
                                                                        maxRows:1
                                                                     paddingTop:4
                                                                  paddingBottom:4
                                                                         insets:UIEdgeInsetsMake(2, 8, 2, 8)
                                                                    containSize:CGSizeMake(KKLayoutContentWidth(), MAXFLOAT)];
    _authorLayout = layout;
}



@end
