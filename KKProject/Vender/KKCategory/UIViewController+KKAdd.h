//
//  UIViewController+KKAdd.h
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KKAdd)

/**
 弹出警戒框,并显示提示信息和block的"确定"和""按钮提响应回调
 
 @param title 警戒框的标题
 @param message 提示的信息
 @param sureTitle sureTitle按钮的标题
 @param cancelTitle cancelTitle按钮的标题
 @param confirmhandler sureTitle的block回调
 @param cancelhandler cancelTitle的block回调
 */
- (void) showAlertWithTitle:(nullable NSString *) title
                    message:(nullable NSString *) message
                 sureAction:(nullable NSString*) sureTitle
               cancelAction:(nullable NSString *) cancelTitle
             confirmhHndler:(void (^ __nullable)(UIAlertAction *action))confirmhandler
              cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelhandler;

/**
 弹出警戒框,并显示提示信息和block的"确定"和""按钮提响应回调
 
 @param title 警戒框的标题
 @param message 提示的信息
 @param actionTitle actionTitle按钮的标题
 @param handler handler的block回调
 */
- (void) showAlertWithTitle:(nullable NSString *)title
                    message:(nullable NSString *) message
                actionTitle:(nonnull NSString *) actionTitle
                    handler:(void (^ __nullable)(UIAlertAction *action))handler;

/**
 弹出警戒框,并显示提示信息和block的"确定"和""按钮提响应回调
 
 @param title 警戒框的标题
 @param message 提示的信息
 @param placeholder 占位符
 @param sureTitle sureTitle按钮的标题
 @param cancelTitle cancelTitle按钮的标题
 @param confirmhandler sureTitle的block回调
 @param cancelhandler cancelTitle的block回调
 */
- (void) showAlertInputWithTitle:(nullable NSString *) title
                         message:(nullable NSString *) message
                     placeholder:(nullable NSString *) placeholder
                      sureAction:(nullable NSString*) sureTitle
                    cancelAction:(nullable NSString *) cancelTitle
                  confirmhHndler:(void (^ __nullable)(UITextField *textfield))confirmhandler
                   cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelhandler;

/**
 弹出警戒框,并显示提示信息和block的"确定"和""按钮提响应回调
 
 @param title 警戒框的标题
 @param message 提示的信息
 @param userNamePalaceholder 占位符
 @param passPalaceholder 占位符
 @param sureTitle sureTitle按钮的标题
 @param cancelTitle cancelTitle按钮的标题
 @param confirmhandler sureTitle的block回调
 @param cancelhandler cancelTitle的block回调
 */
- (void) showAlertInputWithTitle:(nullable NSString *) title
                         message:(nullable NSString *) message
                        userName:(nullable NSString *) userNamePalaceholder
                passPalaceholder:(nullable NSString *) passPalaceholder
                      sureAction:(nullable NSString*) sureTitle
                    cancelAction:(nullable NSString *) cancelTitle
                  confirmhHndler:(void (^ __nullable)(UITextField *usrTextfield,UITextField *pwdTextfield))confirmhandler
                   cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelhandler;


@end

NS_ASSUME_NONNULL_END
