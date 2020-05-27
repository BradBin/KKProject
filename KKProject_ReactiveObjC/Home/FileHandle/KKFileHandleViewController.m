//
//  KKFileHandleViewController.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/18.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKFileHandleViewController.h"


@interface KKFileHandleViewController ()

@end

@implementation KKFileHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self fileHandle];
    
//    [self fileManager];
    
    // Do any additional setup after loading the view.
}


#pragma mark -NSFileHandle
- (void)fileHandle{
    
    
    ///
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    
    NSLog(@"paths:%@",paths);
    
    
    //创建文件
    NSString *doctionaryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) firstObject];
    NSString *sourcePath = [doctionaryPath stringByAppendingPathComponent:@"test.text"];
    
    
    //文件属性设置
    NSDictionary *attributes = @{NSFileOwnerAccountName:@"textName"};
    NSString *saveText = @"NSFileManager写入QQ数据";
    NSData *saveData = [saveText dataUsingEncoding:NSUTF8StringEncoding];
    
    //NSFileManager写入的数据
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager createFileAtPath:sourcePath contents:saveData attributes:attributes];
    NSLog(@"创建文件并写入数据%@:%@",isExist ? @"成功" : @"失败",sourcePath);
    
    
    //NSFileHandle打开文件为了文件操作Updating
    NSFileHandle *ufileHandle = [NSFileHandle fileHandleForUpdatingAtPath:sourcePath];
    //将节点跳转到文件的末尾
    [ufileHandle seekToEndOfFile];
    NSString *qqString = @"追加的数据";
    NSData *qqData = [qqString dataUsingEncoding:NSUTF8StringEncoding];
    
    //写入数据
    NSError *err = nil;
    if (@available(iOS 13.0, *)) {
        [ufileHandle writeData:qqData error:&err];
        NSLog(@"NSFileHandle写入数据:%@",err?err.localizedDescription:@"成功");
    } else {
        [ufileHandle writeData:qqData];
    }
    [ufileHandle closeFile];
    
    
    //将字节跳转到文件指定的位置 仅读Reading
    NSFileHandle *rFileHandle = [NSFileHandle fileHandleForReadingAtPath:sourcePath];
    NSUInteger length = [[rFileHandle availableData] length];
    [rFileHandle seekToFileOffset:length * 0.5];
    NSData *readData = [rFileHandle readDataToEndOfFile];
    NSString *readString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
    NSLog(@"NSFileHandle读取到的数据:%@",readString);
    //NSFileHandle关闭
    [rFileHandle closeFile];
    
    
    //NSFileHandle复制文件
    NSFileHandle *infileHandle , *outfileHanle;//输入文件 输出文件
    NSData *buffer; //读取的缓冲数据
    //输出文件路径
    NSString *outPath = [doctionaryPath stringByAppendingPathComponent:@"outfile.text"];
    BOOL isSuccess = [fileManager createFileAtPath:outPath contents:nil attributes:nil];
    NSLog(@"创建输出文件:%@",isSuccess ? @"成功" : @"失败");
   
    infileHandle = [NSFileHandle fileHandleForReadingAtPath:sourcePath];
    outfileHanle = [NSFileHandle fileHandleForUpdatingAtPath:outPath];
  
    //将输出文件的长度设置为0
    [outfileHanle truncateFileAtOffset:0];
    buffer  = [infileHandle readDataToEndOfFile];
    [outfileHanle writeData:buffer];
    [infileHandle closeFile];
    [outfileHanle closeFile];
    
}

#pragma mark -NSFileManager相关操作
- (void)fileManager{
    NSFileManager *fileManager = NSFileManager.defaultManager;
    //1.创建文件夹
    NSString *dictionaryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
    NSString *createFolder = [dictionaryPath stringByAppendingPathComponent:@"images"];
    NSString *createPhotoFolder = [dictionaryPath stringByAppendingPathComponent:@"photo"];
    [fileManager createDirectoryAtPath:createFolder withIntermediateDirectories:true attributes:nil error:nil];
    [fileManager createDirectoryAtPath:createPhotoFolder withIntermediateDirectories:true attributes:nil error:nil];
    
    
    //2.创建文件
    NSString *createFile      = [createFolder stringByAppendingPathComponent:@"image.plist"];
    NSString *createPhotoFile = [createPhotoFolder stringByAppendingPathComponent:@"photo.plist"];
    [fileManager createFileAtPath:createFile contents:nil attributes:nil];
    [fileManager createFileAtPath:createPhotoFile contents:nil attributes:nil];
    
    //文件是否存在
    BOOL isExists = [fileManager fileExistsAtPath:createFile];
    NSLog(@"文件%@",isExists ? @"存在" :@"不存在");
    
    
    //删除文件
    //    NSError *deleteErr = nil;
    //    [fileManager removeItemAtPath:createPhotoFile error:&deleteErr];
    //     NSLog(@"文件删除: %@",deleteErr?deleteErr.localizedDescription:@"成功");
    
    //    3.复制文件到指定的目录下
    NSError *copyErr = nil;
    [fileManager copyItemAtPath:createFile toPath:createPhotoFile error:&copyErr];
    NSLog(@"文件复制: %@  %@  %@",copyErr?copyErr.localizedDescription:@"成功",createFile,createPhotoFile);
    
    //    4.移动文件到指定目录下
    //    NSError *moveErr = nil;
    //    [fileManager moveItemAtPath:createPhotoFile toPath:createFile error:&moveErr];
    //    NSLog(@"文件移动: %@",moveErr?moveErr.localizedDescription:@"成功");
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
