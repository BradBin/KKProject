//
//  KKFileTransfer.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKDownLoadTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKFileTransfer : NSObject

@property (nonatomic, strong) KKDownLoadTask *downLoadTask;

@end

/***********************
 
 
 
 
************************/

NS_ASSUME_NONNULL_END
