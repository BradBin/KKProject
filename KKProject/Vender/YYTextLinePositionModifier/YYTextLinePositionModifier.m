//
//  YYTextLinePositionModifier.m
//  llyhbzfwxt
//
//  Created by Macbook Pro 15.4  on 2018/3/9.
//  Copyright © 2018年 jadl. All rights reserved.
//

#import "YYTextLinePositionModifier.h"


#pragma mark - EventType implementation
@implementation EventType

@end

#pragma mark - TextLayout implementation
@implementation TextLayout

+(instancetype)layout{
    return [[self alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _height = 0.0;
        _width  = 0.0;
        _textLayout = nil;
    }
    return self;
}

@end



#pragma mark -YYTextLinePositionModifier implementation
@implementation YYTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    if (@available(iOS 9, *)) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Arial
    }
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    //CGFloat ascent = _font.ascender;
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    YYTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    //    CGFloat ascent = _font.ascender;
    //    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}


+ (NSMutableAttributedString *)createAttributedStringWithString:(NSString *)string textColor:(UIColor *)textColor strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor edgeInset:(UIEdgeInsets)edgeInset font:(UIFont *)font cornerRadius:(CGFloat)cornerRadius textAlignment:(NSTextAlignment)textAlignment hightlightState:(BOOL)hightlight{
    
    if (string.length == 0 || string == nil) return [NSMutableAttributedString new];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
  
    [text insertString:@"  " atIndex:0];
    [text appendString:@"  "];
    text.font = font;
    text.color = textColor;
    [text setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:text.rangeOfAll];
    
    YYTextBorder *border = [YYTextBorder new];
    border.strokeWidth = CGFloatPixelRound(1.25);
    border.strokeColor = strokeColor;
    border.fillColor = fillColor;
    border.cornerRadius = cornerRadius; // a huge value
    border.insets = edgeInset;
    [text setTextBackgroundBorder:border range:[text.string rangeOfString:text.string]];
    
    if (hightlight) {
        YYTextBorder *highlightBorder = border.copy;
        highlightBorder.strokeWidth = 0;
        highlightBorder.fillColor   = [UIColor colorWithWhite:0.85 alpha:0.9];
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithHexString:@"#F6F6F6"]];
        [highlight setBackgroundBorder:highlightBorder];
        [text setTextHighlight:highlight range:text.rangeOfAll];
    }
    return text;
}


/**
 创建标签富文本字符串
 
 @param tagStrings 标签文本数组
 @param textColor 文本颜色
 @param font 字体
 @param fillColor 填充色
 @param insets 边距
 @return 标签富文本
 */
+ (NSMutableAttributedString *) createTagAttributedStringWithStrings:(NSArray *)tagStrings
                                                           textColor:(UIColor *)textColor
                                                                font:(UIFont *)font
                                                           fillColor:(UIColor *)fillColor
                                                              insets:(UIEdgeInsets)insets{
    
    NSMutableAttributedString *attrText = NSMutableAttributedString.alloc.init;
    if (tagStrings.count == 0 || tagStrings == nil) return attrText;
    
    for (NSInteger i = 0; i < tagStrings.count; i ++) {
    
        NSString *string = [NSString stringWithFormat:@"%@",tagStrings[i]];
        string = [string stringByTrim];
        if (string.length == 0 || string == nil) break;
    
        NSMutableAttributedString *tagAttr = [[NSMutableAttributedString alloc] initWithString:string];
        [tagAttr insertString:@"  " atIndex:0];
        [tagAttr appendString:@"  "];
        tagAttr.font  = font;
        tagAttr.color = textColor;
        [tagAttr setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:tagAttr.rangeOfAll];
        
        YYTextBorder *border = YYTextBorder.new;
        border.strokeWidth   = 1.0;
        border.fillColor     = fillColor;
        
        border.cornerRadius  = 2.5;
        border.insets        = insets;
        [tagAttr setTextBackgroundBorder:border range:[tagAttr.string rangeOfString:string]];
        [attrText appendAttributedString:tagAttr];
    }
    
    attrText.lineSpacing = 12;
    attrText.lineBreakMode = NSLineBreakByTruncatingTail;
    return attrText;
}


/**
 创建富文本,并返回富文本字符串
 
 @param string 字符串
 @param font 字体大小
 @param textColor 字体颜色
 @param alignment 文本水平对齐方式
 @param content 添加的context(例如图片)
 @param contentMode 添加的context(例如图片)的模式
 @param attachmentSize content的size
 @param textVerticalAlignment 富文本的垂直对齐方式
 @return 文本字符串
 */
+ (NSMutableAttributedString *) createAttributedStringWithString:(NSString *) string font:(UIFont *)font
                                                       textColor:(UIColor *) textColor
                                                       alignment:(NSTextAlignment)alignment
                                               attachmentContent:(id)content
                                                     contentMode:(UIViewContentMode)contentMode
                                                  attachmentSize:(CGSize)attachmentSize
                                           textVerticalAlignment:(YYTextVerticalAlignment)textVerticalAlignment{
    
    NSMutableAttributedString *context = [[NSMutableAttributedString alloc] init];
    
    if (content) {
        NSMutableAttributedString *attactImg = [NSMutableAttributedString attachmentStringWithContent:content contentMode:UIViewContentModeScaleAspectFit attachmentSize:attachmentSize alignToFont:font alignment:textVerticalAlignment];
        [context appendAttributedString:attactImg];
        [context appendString:@" "];
    }
    
    if (string.length == 0) return context;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    attr.color = textColor;
    
    [context appendAttributedString:attr];
    context.alignment = alignment;
    
    return context;
}




/**
 短占位符富文本
 
 @return 富文本对象
 */
+ (NSMutableAttributedString *) pading{
      return [[NSMutableAttributedString alloc] initWithString:@" "];
}



/**
 长占位符富文本
 
 @return 富文本对象
 */
+ (NSMutableAttributedString *) longPading{
    return [[NSMutableAttributedString alloc] initWithString:@"   "];
}





/**
 富文本字符串(图片 字符串 文本字符背景色等等)
 
 @param imgV 图片对象
 @param title 字符串
 @param strokeColor 文本字符串边框色
 @param fillColor 文本字符串背景色
 @param textColor 字体颜色
 @param font 字体
 @param bgInsets 背景色内边距
 @return 富文本字符串
 */
+ (NSMutableAttributedString *) kk_attributedStringWithImgV:(YYAnimatedImageView *)imgV
                                                      title:(NSString *)title
                                            strokeColor:(UIColor *)strokeColor
                                                fillColor:(UIColor *)fillColor
                                                  textColor:(UIColor *)textColor
                                                       font:(UIFont *)font
                                      backgroundColorInsets:(UIEdgeInsets)bgInsets{
    
    NSMutableAttributedString *attrText = NSMutableAttributedString.alloc.init;
    
    if (imgV) {
        NSMutableAttributedString *genderImgVStr = [NSMutableAttributedString attachmentStringWithContent:imgV contentMode:UIViewContentModeScaleAspectFit attachmentSize:imgV.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [attrText appendAttributedString:genderImgVStr];
        
    }
    if (title.length) {
        NSMutableAttributedString *ageAttrStr = [[NSMutableAttributedString alloc] initWithString:title];
        ageAttrStr.color = textColor ? textColor : UIColor.blackColor;
        ageAttrStr.font = font;
        [attrText appendAttributedString:[self pading]];
        [attrText appendAttributedString:ageAttrStr];
        
    }
    
    if (strokeColor || fillColor) {
        YYTextBorder *border = [YYTextBorder new];
        border.strokeWidth   = 1.0;
        border.strokeColor   = strokeColor ? strokeColor : UIColor.whiteColor;
        border.fillColor     = fillColor ? fillColor : UIColor.whiteColor;
        border.cornerRadius  = 100; // a huge value
        border.insets        = bgInsets;
        [attrText setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:attrText.rangeOfAll];
        [attrText setTextBackgroundBorder:border range:attrText.rangeOfAll];
    }
    
    return attrText;
    
}





+ (TextLayout *) layoutWithAttributedString:(NSMutableAttributedString *) attributedString
                                    maxRows:(NSUInteger)maxRows
                                 paddingTop:(CGFloat) paddingTop
                              paddingBottom:(CGFloat) paddingBottom
                                     insets:(UIEdgeInsets)insets
                                containSize:(CGSize)containSize{
    
    TextLayout   *layout = TextLayout.layout;
    CGFloat       textHeight = 0;
    YYTextLayout *textLayout = nil;
    if (attributedString.length == 0 || attributedString == nil) return layout ;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    if (attributedString.length) [text appendAttributedString:attributedString];
    
    text.font = attributedString.font;
    YYTextLinePositionModifier *modifier = [YYTextLinePositionModifier new];
    modifier.font          = attributedString.font;
    modifier.paddingTop    = paddingTop    > 2.1 ? paddingTop : 2.1;
    modifier.paddingBottom = paddingBottom > 2.1 ? paddingBottom : 2.1;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size   = containSize;
    container.insets = insets;
    container.linePositionModifier = modifier;
    container.maximumNumberOfRows  = maxRows ? maxRows : 0;
    
    textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (textLayout == nil) return layout;
    textHeight = [modifier heightForLineCount:textLayout.rowCount];
    layout.height     = textHeight;
    layout.textLayout = textLayout;
    return layout;
}


+ (TextLayout *)layoutWithAttributedString:(nullable NSMutableAttributedString *)insertAddrText
                             insertOfIndex:(NSUInteger)index
                                   context:(nullable NSMutableAttributedString *)contextAddrText
                                     title:(nullable NSMutableAttributedString *)titleAddrText
                             textAlignment:(NSTextAlignment)textAlignment
                                      font:(UIFont *)font
                                   maxRows:(NSUInteger)maxRows
                                paddingTop:(CGFloat) paddingTop
                             paddingBottom:(CGFloat) paddingBottom
                                    insets:(UIEdgeInsets)insets
                               containSize:(CGSize)containSize{
    
    TextLayout *layout = TextLayout.layout;
    CGFloat textHeight = 0;
    YYTextLayout *textLayout = nil;

    if (insertAddrText.length == 0 && contextAddrText.length == 0 && titleAddrText.length == 0) return layout;
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] init];

    if (titleAddrText.length)   [attrText appendAttributedString:titleAddrText];
    if (contextAddrText.length) [attrText appendAttributedString:contextAddrText];
    
    if (index >= attrText.length) {
        NSAssert(false, @"Insertion position across boundaries");
    }else{
        if (insertAddrText.length)  [attrText insertAttributedString:insertAddrText atIndex:index];
    }
    
    attrText.alignment = textAlignment;
    attrText.font      = font;
    
    YYTextLinePositionModifier *modifier = [YYTextLinePositionModifier new];
    modifier.font          = font;
    modifier.paddingTop    = paddingTop >= 0 ? paddingTop : 0;
    modifier.paddingBottom = paddingBottom >= 0 ? paddingBottom : 0;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size   = containSize;
    container.insets = insets;
    container.linePositionModifier = modifier;
    container.maximumNumberOfRows  = maxRows ? maxRows : 0;
    
    textLayout = [YYTextLayout layoutWithContainer:container text:attrText];
    if (textLayout == nil) return layout;
    textHeight        = [modifier heightForLineCount:textLayout.rowCount];
    layout.height     = textHeight;
    layout.textLayout = textLayout;
    return layout;
}


@end
