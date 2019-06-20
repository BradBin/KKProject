//
//  UIView+MBProgressHUD.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/14.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "UIView+MBProgressHUD.h"
#import "MBProgressHUD.h"
#import <objc/message.h>

static inline UIFont *kkFont(){
    return [UIFont systemFontOfSize:14.0f];
}

static inline UIColor *kkTextColor(){
    return [UIColor colorWithRed:0.949 green:0.941 blue:0.941 alpha:1.000];
}

static inline UIColor *kkBackColor(){
    return [UIColor colorWithWhite:0.1 alpha:0.9];
}

typedef NS_ENUM(NSUInteger,ContentType) {
    CustomContentType = 0,
    TextContentType = 1
};

@interface UIView()
@property (assign, nonatomic) ContentType contentType;
@end

static const NSInteger hudViewTag         = 98751235;
static const NSInteger hudAttrTextViewTag = 98751236;//富文本tag
static const CGFloat   navgationBarHeight  = 64;

static void *contentType = &contentType;

@implementation UIView (MBProgressHUD)


#pragma set&get
- (void)setContentType:(ContentType)contentType{
    objc_setAssociatedObject(self, &contentType, @(contentType), OBJC_ASSOCIATION_ASSIGN);
}

- (ContentType)contentType{
    return [objc_getAssociatedObject(self, &contentType) integerValue];
}

#pragma mark - public
/**
 *  文字
 *
 *  @param title title
 */
- (void)showTitle:(NSString *)title
{
    [self showTitle:title yOffset:0];
}

- (void)showTitle:(NSString *)title navigationBar:(BOOL)hiden
{
    hiden?[self showTitle:title yOffset:navgationBarHeight/2.0]:[self showTitle:title yOffset:0];
}

- (void)showTitle:(NSString *)title yOffset:(CGFloat)y;
{
    MBProgressHUD *hud = [self getMBProgressHUD];
    if (hud == nil) {
        hud = [self createHUDIndicatorViewAtCenter:title yOffset:0 imageName:nil contentType:TextContentType];
    }else{
        [self setTextView:hud title:title];
    }
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
}

-(void)showTitle:(NSString *)title completion:(void (^)(void))completion{
    MBProgressHUD *hud = [self getMBProgressHUD];
    if (hud == nil) {
        hud = [self createHUDIndicatorViewAtCenter:title yOffset:0 imageName:nil contentType:TextContentType];
    }else{
        [self setTextView:hud title:title];
    }
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
    if (completion) {
        hud.completionBlock = ^{
            completion();
        };
    }
}

/**
 *  菊花
 *
 */
- (void)showLoadMessageAtCenter{
    [self showLoadMessageAtCenter:@"" yOffset:0];
}

- (void)showLoadMessageAtCenter:(NSString *)title{
    [self showLoadMessageAtCenter:title yOffset:0];
}

- (void)showLoadMessageAtCenter:(NSString *)title navigationBar:(BOOL)hiden{
    hiden?[self showLoadMessageAtCenter:title yOffset:navgationBarHeight/2.0]:[self showLoadMessageAtCenter:title yOffset:0];
}

- (void)showLoadMessageAtCenter:(NSString *)title yOffset:(CGFloat)y;
{
    MBProgressHUD *hud = [self getMBProgressHUD];
    if (hud == nil) {
        hud = [self createHUDIndicatorViewAtCenter:title yOffset:y imageName:nil contentType:CustomContentType];
    }else{
        [self setCustomViewLoading:hud title:title];
    }
    [hud showAnimated:YES];
}

/**
 *  透明菊花
 *
 */
- (void)showClearLoadMessageAtCenter {
    //    [self showLoadMessageAtCenter:@"加载中..." yOffset:0];
    [self showClearLoadMessageAtCenter:@"" yOffset:0];
}

- (void)showClearLoadMessageAtCenter:(NSString *)title{
    [self showClearLoadMessageAtCenter:title yOffset:0];
}

- (void)showClearLoadMessageAtCenter:(NSString *)title navigationBar:(BOOL)hiden{
    hiden?[self showLoadMessageAtCenter:title yOffset:navgationBarHeight/2.0]:[self showLoadMessageAtCenter:title yOffset:0];
}

- (void)showClearLoadMessageAtCenter:(NSString *)title yOffset:(CGFloat)y;
{
    MBProgressHUD *hud = [self getMBProgressHUD];
    if (hud == nil) {
        hud = [self createHUDIndicatorViewAtCenter:title yOffset:y imageName:nil contentType:CustomContentType];
    }else{
        [self setCustomViewLoading:hud title:title];
    }
    hud.bezelView.backgroundColor = UIColor.clearColor;
    [hud.customView removeAllSubviews];
    [hud showAnimated:YES];
}

/**
 *  成功
 *
 *  @param title title
 */
- (void)showSuccess:(NSString *)title{
    [self showSuccess:title yOffset:0];
}

- (void)showSuccess:(NSString *)title navigationBar:(BOOL)hiden{
    hiden?[self showSuccess:title yOffset:navgationBarHeight/2.0]:[self showSuccess:title yOffset:0];
}

- (void)showSuccess:(NSString *)title yOffset:(CGFloat)y{
    NSString *imageName = [NSString stringWithFormat:@"KKCategory.bundle/%@", @"success_white.png"];
    [self showHudSuccessWithError:title yOffset:y imageName:imageName];
}

/**
 *  失败
 *
 *  @param title title
 */
- (void)showError:(NSString *)title{
    [self showError:title yOffset:0];
}

- (void)showError:(NSString *)title navigationBar:(BOOL)hiden
{
    hiden?[self showError:title yOffset:navgationBarHeight/2.0]:[self showError:title yOffset:0];
}

- (void)showError:(NSString *)title yOffset:(CGFloat)y{
    NSString *imageName = [NSString stringWithFormat:@"KKCategory.bundle/%@", @"error_white.png"];
    [self showHudSuccessWithError:title yOffset:y imageName:imageName];
}

- (void)showHudSuccessWithError:(NSString *)title yOffset:(CGFloat)y imageName:(NSString *)imageName{
    MBProgressHUD *hud = [self getMBProgressHUD];
    if (hud == nil) {
        hud = [self createHUDIndicatorViewAtCenter:title yOffset:y imageName:imageName contentType:CustomContentType];
    }else{
        [self setCustomViewComplete:hud title:title imageName:imageName];
    }
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.0];
}

/**
 *  隐藏
 */
- (void)hide
{
    MBProgressHUD *hud = [self getMBProgressHUD];
    [hud hideAnimated:YES];
}

/**
 *  隐藏
 */
- (void)kk_hideProgressHUD {
    [self kk_hideProgressHUDAnimated:YES];
}

- (void)kk_hideProgressHUDAnimated:(BOOL)animated {
    MBProgressHUD *hud = [self getMBProgressHUD];
    [hud hideAnimated:animated];
}

+ (void)showSuccess:(NSString *)title {
    [[UIApplication sharedApplication].keyWindow showSuccess:title];
}

+ (void)showError:(NSString *)title {
    [[UIApplication sharedApplication].keyWindow showError:title];
}

+ (void)showTitle:(NSString *)title {
    [[UIApplication sharedApplication].keyWindow showTitle:title];
}

+(void)showTitle:(NSString *)title completion:(void (^)(void))completion{
    [[UIApplication sharedApplication].keyWindow showTitle:title completion:completion];
}

+ (void)kk_hideProgressHUD {
    [[UIApplication sharedApplication].keyWindow kk_hideProgressHUD];
}

+ (void)kk_hideProgressHUDAnimated:(BOOL)animated {
    [[UIApplication sharedApplication].keyWindow kk_hideProgressHUDAnimated:animated];
}

+ (void)showLoadMessageAtCenter {
    [[UIApplication sharedApplication].keyWindow showLoadMessageAtCenter];
}

+ (void)showClearLoadMessageAtCenter {
    [[UIApplication sharedApplication].keyWindow showClearLoadMessageAtCenter];
}
#pragma mark - private

/**
 创建
 
 @param title title
 @param y y
 @param imageName imageName
 @param contentType contentType
 @return MBProgressHUD对象
 */
- (MBProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)title
                                          yOffset:(CGFloat)y
                                        imageName:(NSString *)imageName
                                      contentType:(ContentType)contentType{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = kkBackColor();
    hud.bezelView.layer.cornerRadius = 3.0f;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.offset = CGPointMake(hud.offset.x, y);
    hud.removeFromSuperViewOnHide = YES;
    hud.tag = hudViewTag;
    [self addSubview:hud];
    switch (contentType) {
            case 0:
            if (imageName) {
                [self setCustomViewComplete:hud title:title imageName:imageName];
            }else{
                [self setCustomViewLoading:hud title:title];
            }
            break;
            case 1:
            [self setTextView:hud title:title];
            break;
        default:
            break;
    }
    return hud;
}

- (void)setCustomViewLoading:(MBProgressHUD *)hud
                       title:(NSString *)title{
    hud.label.text = @"";
    hud.userInteractionEnabled = YES;
    hud.mode = MBProgressHUDModeCustomView;
    
    CGFloat rightLabelHeight = 20;
    CGFloat rightLabelWidth = [self widthWithModelString:title withFontSize:14.0f AndHeight:20];
    hud.margin = 14;
    CGFloat imageWith = rightLabelHeight + hud.margin*2 + rightLabelWidth;
    if (title.length == 0 || [title isEqualToString:@""] || !title) {
        imageWith = rightLabelHeight;
    }
    CGRect imageReact = CGRectMake(0, 0, imageWith, rightLabelHeight);
    UIGraphicsBeginImageContext(imageReact.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, imageReact);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *showImageView =  [[UIImageView alloc] initWithImage:theImage];
    hud.customView = showImageView;
    
    UIView *leftLoadingView = [[UIView alloc] initWithFrame:CGRectMake(hud.margin/2.0f, 0, imageReact.size.height, imageReact.size.height)];
    CAShapeLayer *centerLayer = [self radiusLayer:CGPointMake(imageReact.size.height/2.0f, imageReact.size.height/2.0f)];
    [leftLoadingView.layer addSublayer:centerLayer];
    [self radiusLayerStarAnimationWithLayer:leftLoadingView.layer];
    [hud.customView addSubview:leftLoadingView];
    if (title.length == 0 || [title isEqualToString:@""] || !title) {
        leftLoadingView.center = hud.customView.center;
    }
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLoadingView.frame)+hud.margin, 0, rightLabelWidth, rightLabelHeight)];
    rightLabel.text = title;
    rightLabel.font = kkFont();
    rightLabel.textColor = kkTextColor();
    [hud.customView addSubview:rightLabel];
}

- (void)setCustomViewComplete:(MBProgressHUD *)hud
                        title:(NSString *)title
                    imageName:(NSString *)imageName{
    hud.bezelView.backgroundColor = kkBackColor();
    hud.userInteractionEnabled = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.label.numberOfLines = 0;
    hud.label.text = title;
    hud.label.font = kkFont();
    hud.label.textColor = kkTextColor();
}

- (void)setTextView:(MBProgressHUD *)hud
              title:(NSString *)title{
    hud.bezelView.backgroundColor = kkBackColor();
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    hud.label.font = kkFont();
    hud.label.textColor = kkTextColor();
    hud.label.numberOfLines = 0;
    
}

- (MBProgressHUD *)getMBProgressHUD{
    for (UIView *view in self.subviews)
    {
    if (view.tag == hudViewTag) {
        if (view != nil && [view isKindOfClass:[MBProgressHUD class]]){
            return (MBProgressHUD *)view;
        }else{
            return nil;
        }
        break;
    }
    }
    return nil;
}

- (MBProgressHUD *)getAttrTextMBProgressHUD{
    for (UIView *view in self.subviews)
    {
    if (view.tag == hudAttrTextViewTag) {
        if (view != nil && [view isKindOfClass:[MBProgressHUD class]]){
            return (MBProgressHUD *)view;
        }else{
            return nil;
        }
        break;
    }
    }
    return nil;
}

#pragma mark -
/**
 *  获取圈的layer
 *
 *  @return CAShapeLayer对象
 */
- (CAShapeLayer *)radiusLayer:(CGPoint )point{
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithArcCenter:point radius:point.x startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=beizPath.CGPath;
    layer.fillColor=[UIColor clearColor].CGColor;//填充色
    layer.strokeColor=kkTextColor().CGColor;//边框颜色
    layer.lineWidth=2.0f;
    layer.lineCap=kCALineCapRound;//线框类型
    return layer;
}

/**
 *  转圈动画
 *
 *  @param layer layer
 */
- (void)radiusLayerStarAnimationWithLayer:(CALayer *)layer
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue=@(0);
    animation.toValue=@(M_PI*2);
    animation.duration=.8;
    animation.repeatCount=HUGE;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"animation"];
}

/**
 计算label的宽度
 
 @param string string
 @param font string
 @param height height
 @return label的宽度
 */
- (CGFloat) widthWithModelString:(NSString*)string withFontSize:(CGFloat )font AndHeight:(CGFloat)height
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:style} context:nil].size;
    return size.width + 1;
}

@end
