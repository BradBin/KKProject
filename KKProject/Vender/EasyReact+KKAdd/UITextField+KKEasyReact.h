//
//  UITextField+KKEasyReact.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EasyReact/EasyReact.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (KKEasyReact)
@property (nonatomic,strong,readonly) EZRMutableNode<NSString *> *ezr_textNode;
    
    
    
@end

NS_ASSUME_NONNULL_END
