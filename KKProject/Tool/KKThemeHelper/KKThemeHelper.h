//
//  KKThemeHelper.h
//  KKProject
//
//  Created by youbin on 2020/1/21.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKThemeHelper : NSObject

+(instancetype)shared;

-(void)setAlternateIcon:(NSString *_Nonnull)alternateIconName
      completionHandler:(void(^_Nullable)(NSError *_Nullable error))completionHandler  API_AVAILABLE(ios(10.3));

@end

NS_ASSUME_NONNULL_END
