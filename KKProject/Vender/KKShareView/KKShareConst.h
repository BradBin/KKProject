//
//  KKShareConst.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/21.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


static inline CGSize screenSize(){
    return UIScreen.mainScreen.bounds.size;
}

static inline UIEdgeInsets safeEdgeInsets(){
    UIEdgeInsets safeInsets = UIEdgeInsetsZero;
    if (@available(iOS 11, *)) {
        safeInsets = UIApplication.sharedApplication.keyWindow.safeAreaInsets;
    }
    return safeInsets;
}

static inline CGFloat margin(){
    return CGFloatPixelRound(8.0);
}

static inline CGFloat marginV(){
    return CGFloatPixelRound(15.0);
}

static inline CGFloat collectionHeight(){
    return CGFloatPixelRound(100);
}

static inline CGFloat cancelHeight(){
    return CGFloatPixelRound(44.0f);
}

static inline CGFloat titleHeight(){
    return CGFloatPixelRound(70);
}


static inline CGFloat shareHeight(){
    return CGFloatPixelRound(260);
}
