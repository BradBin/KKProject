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
    [self kk_pictureLayout];
    [self kk_videoLayout];
    
    switch (_content.type) {
        case KKHomeDataFileTypeImage_Video:
        case KKHomeDataFileTypeImage_Mutli:
        case KKHomeDataFileTypeImage_None:
        {
            if (_titleLayout.height) _height += _titleLayout.height;
            if (_pictureHeight)      _height += _pictureHeight;
            
        }break;
        case KKHomeDataFileTypeImage_Single:
        {
            _height += _titleLayout.height >= _pictureHeight ? _titleLayout.height : _pictureHeight;
        }break;
        default:
            if (_titleLayout.height) _height += _titleLayout.height;
            break;
    }
    
    if (_videoHeight)           _height += _videoHeight;
    if (_authorLayout.height)   _height += _authorLayout.height;
    if (_abstractLayout.height) _height += _abstractLayout.height;
    
    if (_height) {
        self.marginTop     = self.marginTop    * 2;
        self.marginBottom = self.marginBottom * 2;
        _height += self.marginTop;
        _height += self.marginBottom;
    }
}




- (void)kk_titleLayout{
    
    CGFloat width = KKLayoutContentWidth();
    switch (_content.type) {
        case KKHomeDataFileTypeImage_Video:
        case KKHomeDataFileTypeImage_Mutli:
        case KKHomeDataFileTypeImage_None:
            width = KKLayoutContentWidth();
            break;
        case KKHomeDataFileTypeImage_Single:
            width = (KKLayoutContentWidth() - KKLayoutContentImageWidth());
            break;
        default:
            width = KKLayoutContentWidth();
            break;
    }
    
    NSString *feedTitle = _content.title;
    if (feedTitle.isNotBlank == false) return;
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:feedTitle];
    attrText.color                      = KKDefaultTitleColor();
    attrText.font                       = KKDefaultTitleFont();
    attrText.lineSpacing                = 100;
    
    TextLayout *layout = [YYTextLinePositionModifier layoutWithAttributedString:attrText
                                                                        maxRows:3
                                                                     paddingTop:8
                                                                  paddingBottom:8
                                                                         insets:UIEdgeInsetsMake(8, 4, 8, 4)
                                                                    containSize:CGSizeMake(width, MAXFLOAT)];
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
                                                                         insets:UIEdgeInsetsMake(8, 4, 8, 4)
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
    attrText.font                       = KKDefaultFontSize(11.0f);
    attrText.lineBreakMode              = NSLineBreakByTruncatingTail;
    
    TextLayout *layout = [YYTextLinePositionModifier layoutWithAttributedString:attrText
                                                                        maxRows:1
                                                                     paddingTop:8
                                                                  paddingBottom:8
                                                                         insets:UIEdgeInsetsMake(8, 4, 8, 4)
                                                                    containSize:CGSizeMake(KKLayoutContentWidth(), MAXFLOAT)];
    _authorLayout = layout;
}

- (void)kk_pictureLayout{
    
    switch (_content.type) {
        case KKHomeDataFileTypeImage_Mutli:
        {
            KKHCTTImageModel *imageModel = (KKHCTTImageModel *)[_content.image_list firstObject];
            _pictureHeight = KKLayoutContentImageWidth() * 1.0f * imageModel.height / imageModel.width;
        }break;
        case KKHomeDataFileTypeImage_Single:
        {
            KKHCTTImageModel *imageModel = (KKHCTTImageModel *)_content.middle_image;
            _pictureHeight = KKLayoutContentImageWidth() * 1.0f* imageModel.height / imageModel.width;
        }break;
            
        default:
            _pictureHeight = 0.0f;
            break;
    }
}

- (void)kk_videoLayout{
    if (_content.type == KKHomeDataFileTypeImage_Video) {
        KKHCTTImageModel * imageMode;
        if (_content.large_image_list.count) {
            imageMode = _content.large_image_list.firstObject;
        }else{
            imageMode = _content.image_list.firstObject;
        }
        if (imageMode.width && imageMode.height) {
            _videoHeight = KKLayoutContentWidth() * 1.0f * imageMode.height / imageMode.width;
        }else{
            _videoHeight = 0.0f;
        }
    }else{
        _videoHeight = 0.0f;
    }
}

@end
