//
//  UITextField+KKEasyReact.m
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/5/1.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "UITextField+KKEasyReact.h"
#import <objc/runtime.h>

@implementation UITextField (KKEasyReact)
    
- (EZRMutableNode<NSString *> *)ezr_textNode {
    EZRMutableNode<NSString *> *node = objc_getAssociatedObject(self, @selector(ezr_textNode));
    if (node == nil) {
        node = [self generatorTextNode];
        objc_setAssociatedObject(self, @selector(ezr_textNode), node, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return node;
}
    
- (EZRMutableNode<NSString *> *)generatorTextNode {
    EZRMutableNode<NSString *> *node = [EZRMutableNode new];
    @ezr_weakify(self, node)
    [[node listenedBy:self] withContextBlock:^(NSString * _Nullable next, id  _Nullable context) {
        @ezr_strongify(self)
        if (![context isEqualToString:[self uniqueContext]]) {
            self.text = next;
        }
    }];
    [self addTarget:self action:@selector(ezr_textChanged:) forControlEvents:UIControlEventEditingChanged];
    [[EZR_PATH(self, text) listenedBy:self] withBlock:^(id  _Nullable next) {
        @ezr_strongify(self, node)
        [node setValue:next context:[self uniqueContext]];
    }];
    return node;
}
    
- (void)ezr_textChanged:(UITextField *)sender {
    [sender.ezr_textNode setValue:sender.text context:[sender uniqueContext]];
}
    
- (NSString *)uniqueContext {
    return [NSString stringWithFormat:@"ezr_updateText_%p", self];
}
    
@end
