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

@end

NS_ASSUME_NONNULL_END
