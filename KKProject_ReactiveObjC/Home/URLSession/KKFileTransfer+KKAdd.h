//
//  KKFileTransfer+KKAdd.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKFileTransfer.h"

NS_ASSUME_NONNULL_BEGIN

 struct KKFileSize{
    NSError   *error;
    NSInteger fileSize;
};

@interface KKFileTransfer (KKAdd)


/// 获取文件路径下文件的属性
/// @param path 文件路径
-(struct KKFileSize)fileLengthAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
