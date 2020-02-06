//
//  KKProjectAPI.h
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#ifndef KKProjectAPI_h
#define KKProjectAPI_h

#if ENV_CODE == ENV_PROJECT
#define KK_BASE_URL       @"https://is.snssdk.com/"

#elif ENV_CODE == ENV_PROJECT_OBJC
#define KK_BASE_URL       @"https://is.snssdk.com/"

#endif

#define KK_ACCOUNT_IID          @"17769976909"
#define kk_DEVICE_ID            @"41312231473"
#define KK_CATEGORY_TITLE       @"article/category/get_subscribed/v1/?"
#define KK_Home_CATEGORY_LIST   @"api/news/feed/v58/?"

#endif /* KKProjectAPI_h */
