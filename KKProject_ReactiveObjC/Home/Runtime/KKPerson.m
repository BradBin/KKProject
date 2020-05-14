//
//  KKPerson.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/10.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKPerson.h"
#import <objc/message.h>
#import <objc/runtime.h>

/***************************
 
 Rutime消息发送
 OC调用方法被编译: objc_msgSend,除此之外还有objc_msgSendSuper,objc_msgSend_stret,objc_msgSendSuper_stret其中super是
 调用父类的方法;如果返回值是结构体而不是简单值,需要使用带有stret的方法
 
 运行时阶段的消息发送步骤:
 1.检测selector是不是需要忽略的.比如Mac OSX开发,有了垃圾回收就不理会retain,release等函数方法
 2.检测target是不是为nil对象.OC的特性是允许对一个nil对象执行任何一个方法不汇报crash,因为会被忽略掉.
 3.上面两个方法都通过了,那就开始查找这个类的IMP,先从cache里面寻找;若找到就跳到对应的函数中去执行.
 4.若cache中没有找到,就去方法列表中methodlists中寻找-->父类的方法列表methodlists-->NSObject类中为止
 5.若还没有找到,Runtime就提供三种方法来处理: 1.动态方法解析  2.消息接收者重定向  3.消息定向
                       三者的调用关系
            消息动态解析********************
                *             NO         *
                *                        *
                *return                  *                nil
                *YES                消息接收者重定向************
                *                        *                   *
                *                        *                   *
                *              return    *               消息重定向*******消息处理异常
                *            new receiver*                   *
                *                        *                   *
                *                        *                   *
        ***************************消息处理成功********************************
  
 
 1.动态方法解析：Perosn类中声明方法却未添加实现，我们通过Runtime动态方法解析的操作为其他添加方法实现
 
 OC方法：
 类方法未找到时调起，可于此添加类方法实现
 + (BOOL)resolveClassMethod:(SEL)sel
 实例方法未找到时调起，可于此添加实例方法实现
 + (BOOL)resolveInstanceMethod:(SEL)sel

 Runtime方法：
  运行时方法：向指定类中添加特定方法实现的操作
  @param cls 被添加方法的类
  @param name selector方法名
  @param imp 指向实现方法的函数指针
  @param types imp函数实现的返回值与参数类型
  @return 添加方法是否成功

 BOOL class_addMethod(Class _Nullable cls,
                      SEL _Nonnull name,
                      IMP _Nonnull imp,
                      const char * _Nullable types)
 
 ***************************/

@implementation KKPerson
/****动态方法解析(Dynamic Method Resolution)*****/


/// 类方法的实现未找到时调起,可在此添加类方法实现,避免崩溃
/// @param sel sel
+ (BOOL)resolveClassMethod:(SEL)sel{
    if(sel == @selector(haveMeal:)){
        ///运行时方法：向指定类中添加特定方法实现的操作
        class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(kk_haveMeal:)), "v@");
        return YES;   //添加函数实现，返回YES
    }
    return [class_getSuperclass(self) resolveClassMethod:sel];
}


/// 实例方法的实现未找到时调起,可在此添加实例方法实现,避免崩溃
/// @param sel sel
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if(sel == @selector(singSong:)){
        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(kk_singSong:)), "v@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//+(void)haveMeal:(NSString *)food{
//    NSLog(@"吃的%@",food);
//}

//-(void)singSong:(NSString *)songName{
//    NSLog(@"歌曲名称:%@",songName);
//}

+ (void)kk_haveMeal:(NSString *)food{
    NSLog(@"%s haveMeal:未实现",__func__);
}

- (void)kk_singSong:(NSString *)name{
    NSLog(@"%s singSong:未实现",__func__);
}

@end






@implementation KKPersonHelper

/// 拥有的技能
/// @param skill 技能
-(void)haveSkill:(NSString *)skill{
    NSLog(@"KKEngineerHelper : %@",skill);
}
+(void)haveSkill:(NSString *)skill{
    NSLog(@"KKEngineerHelper : %@",skill);
}

-(void)haveFood:(NSString *)food{
    NSLog(@"农民有粮食:%@",food);
}

-(void)haveFruit:(NSString *)fruit{
    NSLog(@"果农有水果:%@",fruit);
}

+(void)haveFruit:(NSString *)fruit{
    NSLog(@"果农有水果:%@",fruit);
}


@end

@implementation KKEngineer

/**
 methodSignatureForSelector用于描述被转发的消息，系统会调用methodSignatureForSelector:方法，尝试获得一个方法签名。如果获取不到，则直接调用doesNotRecognizeSelector抛出异常。如果能获取，则返回非nil：创建一个 NSlnvocation 并传给forwardInvocation:
 */
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(haveSkill:)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}


///forwardingTargetForSelector仅支持一个对象的返回，也就是说消息只能被转发给一个对象
///forwardInvocation可以将消息同时转发给任意多个对象
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    if (anInvocation.selector == @selector(haveSkill:)) {
        KKPersonHelper *keh = KKPersonHelper.alloc.init;
        [anInvocation invokeWithTarget:keh];
        
        KKPersonHelper *keh1 = KKPersonHelper.alloc.init;
        [anInvocation invokeWithTarget:keh1];
        
    }else{
        [super forwardInvocation:anInvocation];
    }
}

+(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(haveSkill:)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}


///forwardingTargetForSelector仅支持一个对象的返回，也就是说消息只能被转发给一个对象
///forwardInvocation可以将消息同时转发给任意多个对象
+(void)forwardInvocation:(NSInvocation *)anInvocation{
    id target = [KKPersonHelper class];
    if ([target respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:target];
    }else{
        [super forwardInvocation:anInvocation];
    }
}


@end









@implementation KKFarmer

+(id)forwardingTargetForSelector:(SEL)aSelector{
    return [KKPersonHelper class];
}

-(id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(haveFruit:)) {
        return [[KKPersonHelper alloc] init];
    }
     return [super forwardingTargetForSelector:aSelector];
}

/// 触发崩溃方法
/// @param aSelector 方法
-(void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"触发崩溃 : %@ ",NSStringFromSelector(aSelector));
}

@end



/*****************************************
 class_addMethod方法中的特殊参数“v@”
 Table 6-1  Objective-C type encodings
 Code               Meaning
 c                  A char
 i                  An int
 s                  A short
 l                  A long
                    l is treated as a 32-bit quantity on 64-bit programs.
 q                  A long long
 C                  An unsigned char
 I                  An unsigned int
 S                  An unsigned short
 L                  An unsigned long
 Q                  An unsigned long long
 f                  A float
 d                  A double
 B                  A C++ bool or a C99 _Bool
 v                  A void
 *                  A character string (char *)
 @                  An object (whether statically typed or typed id)
 #                  A class object (Class)
 :                  A method selector (SEL)
 [array type]       An array
 {name=type...}     A structure
 (name=type...)     A union
 bnum               A bit field of num bits
 ^type              A pointer to type
 ?                  An unknown type (among other things, this code is used for function pointers)

 ****************************************/
