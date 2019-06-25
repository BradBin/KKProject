//
//  KKSettingsViewModel.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewModel.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString * const KKCellIdentifier;
UIKIT_EXTERN NSString * const KKRightLabelCellIdentifier;
UIKIT_EXTERN NSString * const KKRightViewCellIdentifier;

@interface KKSettingsViewModel : KKViewModel

@property (nonatomic,strong,readonly) NSArray *dataSources;
@property (nonatomic,strong) RACSubject *cleanSubject;


@end

NS_ASSUME_NONNULL_END