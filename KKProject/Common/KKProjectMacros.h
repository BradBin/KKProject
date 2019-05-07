//
//  KKProjectMacros.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/4/25.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#ifndef KKProjectMacros_h
#define KKProjectMacros_h

#define ENV_PROJECT      0
#define ENV_PROJECT_OBJC 1

#if   ENV_CODE == ENV_PROJECT

#import "KKProjectHeader.h"



#elif ENV_CODE == ENV_PROJECT_OBJC

#import "KKProjectObjcHeader.h"

#endif


#endif /* KKProjectMacros_h */


