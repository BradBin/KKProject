//
//  KKHomeViewModel.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/6.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKHomeViewModel : KKViewModel
@property (nonatomic,strong) RACCommand *categoryCommand;
@property (nonatomic,strong) RACSubject *categoryUISubject;

@end

NS_ASSUME_NONNULL_END
