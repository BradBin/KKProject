//
//  KKHomeViewCell.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/19.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKTableViewCell.h"
#import "KKHomeLayout.h"

NS_ASSUME_NONNULL_BEGIN
UIKIT_EXTERN NSString * const KKHomeViewCellIdentifier;
@interface KKHomeViewCell : KKTableViewCell

@property (nonatomic,strong) KKHomeLayout *layout;

@property (nonatomic,strong) UIView  *lineView;
@property (nonatomic,strong) YYLabel *titlelabel;
@property (nonatomic,strong) YYLabel *abstractlabel;
@property (nonatomic,strong) YYLabel *authorlabel;
@property (nonatomic,strong) YYAnimatedImageView *previewImgV;

@end



UIKIT_EXTERN NSString * const KKHomeViewImageCellIdentifier;
@interface KKHomeViewImageCell : KKHomeViewCell

@end

NS_ASSUME_NONNULL_END
