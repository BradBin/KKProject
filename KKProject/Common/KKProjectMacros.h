//
//  KKProjectMacros.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/4/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#ifndef KKProjectMacros_h
#define KKProjectMacros_h


#define IM_AppKey          @"45c6af3c98409b18a84451215d0bdd6e"
#define ACCOUNT            @"youbin1992"
#define PASSWORD           @"864bf8f37c6710845857585b9cd04407"

#define UMengKey           @"5c36e5a7f1f5561a92000ab8"
#define UMengMasterSecret  @"dyg5aaww2udea3fw9uelvmghmr8zg6z9"

#define weChatAppId        @"5c36e5a7f1f5561a92000ab8"
#define weChatAppSecret    @"dyg5aaww2udea3fw9uelvmghmr8zg6z9"

#define QQAppKey           @"5c36e5a7f1f5561a92000ab8"
#define QQAppSecret        @"dyg5aaww2udea3fw9uelvmghmr8zg6z9"



#define ENV_PROJECT      0
#define ENV_PROJECT_OBJC 1

#if   ENV_CODE == ENV_PROJECT

#import "KKProjectHeader.h"

#elif ENV_CODE == ENV_PROJECT_OBJC

#import "KKProjectObjcHeader.h"

#endif

#import "KKProjectConst.h"



#endif /* KKProjectMacros_h */


