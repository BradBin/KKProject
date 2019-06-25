//
//  KKSettingsTableCell.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTableViewCell.h"
#import "KKTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKRightTableCell : KKTableViewCell

@property (nonatomic,strong) YYAnimatedImageView *leftImagV;
@property (nonatomic,strong) YYLabel             *titlelabel;
@property (nonatomic,strong) UIView              *rightView;

- (void)kk_showArrow:(BOOL)isShow;
- (void)kk_setImage:(UIImage *)image title:(NSString *)title;

- (CGSize)kk_imageViewSize;

@end




@interface KKContentTableCell : KKRightTableCell

@property (nonatomic,strong) YYLabel *sublabel;


- (void)kk_setTitle:(NSString *)title subTitle:(NSString *)subtitle;
- (void)kk_setImg:(nullable UIImage *)image title:(NSString *)title subTitle:(NSString *)subtitle;

@end





@interface KKTextFieldTableCell : KKRightTableCell

@property (nonatomic,strong) KKTextField *textfield;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end



NS_ASSUME_NONNULL_END
