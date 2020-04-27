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

@interface KKHomeViewCell : KKTableViewCell

@property (nonatomic,strong) KKHomeLayout *layout;
@property (nonatomic,strong) UIView  *lineView;
@property (nonatomic,strong) YYLabel *titlelabel;
@property (nonatomic,strong) YYLabel *abstractlabel;
@property (nonatomic,strong) YYLabel *authorlabel;
@property (nonatomic,strong) YYAnimatedImageView *rightImgV;

@end



UIKIT_EXTERN NSString * const KKHomeViewTextCellIdentifier;
@interface KKHomeViewTextCell : KKHomeViewCell

@end



UIKIT_EXTERN NSString * const KKHomeViewImageCellIdentifier;
@interface KKHomeViewImageCell : KKHomeViewCell
@property (nonatomic,strong) YYAnimatedImageView *leftImgV;
@property (nonatomic,strong) YYAnimatedImageView *midImgV;

@end


UIKIT_EXTERN NSString * const KKHomeViewRightImageCellIdentifier;
@interface KKHomeViewRightImageCell : KKHomeViewCell

@end



UIKIT_EXTERN NSString * const KKHomeViewVideoCellIdentifier;
@interface KKHomeViewVideoCell : KKHomeViewCell
@property (nonatomic,strong) YYAnimatedImageView *coverImgV;

@end

NS_ASSUME_NONNULL_END
