//
//  KKFileTransfer+KKAdd.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/16.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKFileTransfer+KKAdd.h"

@implementation KKFileTransfer (KKAdd)


-(struct KKFileSize)fileLengthAtPath:(NSString *)path{
    struct KKFileSize fileStruct;
    NSInteger fileSize = 0;
    NSError *error = nil;
    NSFileManager *fileManager = NSFileManager.defaultManager;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    fileStruct.error    = error;
    fileStruct.fileSize = fileSize;
    return fileStruct;
}

@end
