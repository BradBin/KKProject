//
//  UIViewController+KKAdd.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/26.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "UIViewController+KKAdd.h"
#import "AppDelegate.h"

@implementation UIViewController (KKAdd)

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
              cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelhandler{
    
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:confirmhandler];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:cancelhandler];
    
    [alertContr addAction:sureAction];
    [alertContr addAction:cancelAction];
    
    //    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self presentViewController:alertContr animated:YES completion:nil];
    
}

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
                    handler:(void (^ __nullable)(UIAlertAction *action))handler{
    
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:title
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:actionTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:handler];
    
    [alertContr addAction:sureAction];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController presentViewController:alertContr animated:YES completion:nil];
    
}

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
                   cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelhandler{
    
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertContr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           UITextField *textfield = alertContr.textFields.firstObject;
                                                           if (confirmhandler) {
                                                               confirmhandler(textfield);
                                                           }
                                                       }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:cancelhandler];
    sureAction.enabled = false;
    [alertContr addAction:sureAction];
    [alertContr addAction:cancelAction];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController presentViewController:alertContr animated:YES completion:nil];
    
}


- (void) textFieldChange:(UITextField *) textfield{
    
    UIViewController *appRootContr = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (appRootContr.presentedViewController) {
        appRootContr = appRootContr.presentedViewController;
    }
    
    UIAlertController *alertController = (UIAlertController *)appRootContr;
    if (alertController){
        NSString *string = alertController.textFields.firstObject.text;
        
        UIAlertAction *sureAction = alertController.actions.firstObject;
        sureAction.enabled = string.length ? true : false;
    }
}

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
                   cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancelhandler{
    
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertContr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = userNamePalaceholder;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self action:@selector(mutliTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    [alertContr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = passPalaceholder;
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self action:@selector(mutliTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           UITextField *user = alertContr.textFields.firstObject;
                                                           UITextField *pwd = alertContr.textFields.lastObject;
                                                           if (confirmhandler) {
                                                               confirmhandler(user,pwd);
                                                           }
                                                       }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:cancelhandler];
    sureAction.enabled = false;
    [alertContr addAction:sureAction];
    [alertContr addAction:cancelAction];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController presentViewController:alertContr animated:YES completion:nil];
}

- (void) mutliTextFieldChange:(UITextField *) textfield{
    
    UIViewController *appRootContr = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (appRootContr.presentedViewController) {
        appRootContr = appRootContr.presentedViewController;
    }
    
    UIAlertController *alertController = (UIAlertController *)appRootContr;
    if (alertController){
        NSString *userName = alertController.textFields.firstObject.text;
        NSString *password = alertController.textFields.lastObject.text;
        
        UIAlertAction *sureAction = alertController.actions.firstObject;
        
        NSString *regex = @"^1\\d{10}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        BOOL result =  [predicate evaluateWithObject:password];
        sureAction.enabled = userName.length > 0 && result ? true : false;
    }
}



@end
