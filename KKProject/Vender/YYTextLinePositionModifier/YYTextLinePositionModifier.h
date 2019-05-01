//
//  YYTextLinePositionModifier.h
//  llyhbzfwxt
//
//  Created by Macbook Pro 15.4  on 2018/3/9.
//  Copyright © 2018年 jadl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYKit.h"


NS_ASSUME_NONNULL_BEGIN

@interface EventType : NSObject

@property (nonatomic,strong) UIColor *eventColor;
@property (nonatomic,copy)  NSString *eventName;

@end


/**
 布局保存类
 */
@interface TextLayout : NSObject

@property (nonatomic,strong) YYTextLayout  *textLayout;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;

+ (instancetype) layout;

@end


/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface YYTextLinePositionModifier : NSObject<YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Arial/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数

- (CGFloat)heightForLineCount:(NSUInteger)lineCount;


/**
 创建富文本字符串,并设置字符的背景颜色,边框颜色、点击等属性

 @param string 字符串
 @param textColor 文本颜色
 @param strokeColor 边框颜色
 @param fillColor 填充颜色
 @param edgeInset 边距
 @param font 字体
 @param cornerRadius 圆角
 @param textAlignment 对齐方式
 @param hightlight 点击
 @return 富文本字符串
 */
+ (NSMutableAttributedString *)createAttributedStringWithString:(nonnull NSString *)string
                                                      textColor:(UIColor *)textColor
                                                    strokeColor:(UIColor *)strokeColor
                                                      fillColor:(UIColor *)fillColor
                                                      edgeInset:(UIEdgeInsets)edgeInset
                                                           font:(UIFont *)font
                                                   cornerRadius:(CGFloat)cornerRadius
                                                  textAlignment:(NSTextAlignment)textAlignment
                                                hightlightState:(BOOL)hightlight;

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
                                                              insets:(UIEdgeInsets)insets;

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
+ (NSMutableAttributedString *) createAttributedStringWithString:(nullable NSString *) string
                                                            font:(UIFont *)font
                                                       textColor:(UIColor *) textColor
                                                       alignment:(NSTextAlignment)alignment
                                               attachmentContent:(nullable id)content
                                                     contentMode:(UIViewContentMode)contentMode
                                                  attachmentSize:(CGSize)attachmentSize
                                           textVerticalAlignment:(YYTextVerticalAlignment)textVerticalAlignment;





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
+ (NSMutableAttributedString *) kk_attributedStringWithImgV:(nullable YYAnimatedImageView *)imgV
                                                      title:(nullable NSString *)title
                                                strokeColor:(nullable UIColor *)strokeColor
                                                  fillColor:(nullable UIColor *)fillColor
                                                  textColor:(nullable UIColor *)textColor
                                                       font:(UIFont *)font
                                      backgroundColorInsets:(UIEdgeInsets)bgInsets;

/**
 短占位符富文本

 @return 富文本对象
 */
+ (NSMutableAttributedString *) pading;



/**
 长占位符富文本
 
 @return 富文本对象
 */
+ (NSMutableAttributedString *) longPading;




/**
 控件的布局

 @param attributedString 富文本
 @param maxRows 行数(0:不限)
 @param paddingTop 文本内容上边距
 @param paddingBottom 文本内容下边距
 @param insets 内边距
 @param containSize 文本的size
 @return 布局后对象
 */
+ (TextLayout *) layoutWithAttributedString:(NSMutableAttributedString *) attributedString
                                    maxRows:(NSUInteger)maxRows
                                 paddingTop:(CGFloat) paddingTop
                              paddingBottom:(CGFloat) paddingBottom
                                     insets:(UIEdgeInsets)insets
                                containSize:(CGSize)containSize;

/**
 控件的布局

 @param insertAddrText 待插入的富文本
 @param index 插入富文本的位置
 @param contextAddrText 文本内容
 @param titleAddrText 文本前的标题字符串
 @param textAlignment 对齐方式
 @param font 字体
 @param maxRows 行数(0:不限制)
 @param paddingTop 文本内容上边距
 @param paddingBottom 文本内容下边距
 @param insets 文本内边距
 @param containSize 控件size
 @return buju 布局对象
 */
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
                               containSize:(CGSize)containSize;



@end


NS_ASSUME_NONNULL_END
