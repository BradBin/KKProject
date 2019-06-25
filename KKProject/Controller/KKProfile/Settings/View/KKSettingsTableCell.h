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

@interface KKSettingsTableCell : KKTableViewCell

@property (nonatomic,strong) YYAnimatedImageView *leftImagV;
@property (nonatomic,strong) YYLabel             *titlelabel;
@property (nonatomic,strong) UIView              *rightView;

- (void)kk_showArrow:(BOOL)isShow;
- (void)kk_setImage:(nullable UIImage *)image title:(NSString *)title;

- (CGSize)kk_imageViewSize;

@end




@interface KKContentTableCell : KKSettingsTableCell

@property (nonatomic,strong) YYLabel *sublabel;

- (void)kk_setTitle:(NSString *)title subTitle:(NSString *)subtitle;
- (void)kk_setImg:(nullable UIImage *)image title:(NSString *)title subTitle:(NSString *)subtitle;

@end



@interface KKTextFieldTableCell : KKSettingsTableCell

@property (nonatomic,strong) UITextField *textfield;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end



NS_ASSUME_NONNULL_END
