//
//  KKFileTransfer.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKFileTransfer.h"

@interface KKFileTransfer ()


@end

@implementation KKFileTransfer



-(KKDownLoadTask *)downLoadTask{
    if (_downLoadTask == nil) {
        _downLoadTask = KKDownLoadTask.alloc.init;
    }
    return _downLoadTask;
}

@end
