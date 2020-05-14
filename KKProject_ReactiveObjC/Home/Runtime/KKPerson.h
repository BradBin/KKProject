//
//  KKPerson.h
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/5/10.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/***********************************************
 Runtime提供三种方式来将原来的方法实现代替掉，那该怎样选择它们呢？

 Method Resolution：由于Method Resolution不能像消息转发那样可以交给其他对象来处理，所以只适用于在原来的类中代替掉。
 Fast Forwarding：它可以将消息处理转发给其他对象，使用范围更广，不只是限于原来的对象。
 Normal Forwarding：它跟Fast Forwarding一样可以消息转发，但它能通过NSInvocation对象获取更多消息发送的信息，例如：target、selector、arguments和返回值等信息。


************************************************/


#pragma Mark - 消息动态解析
@interface KKPerson : NSObject

/// 声明类方法,但未实现
/// @param food 食物名称
+(void)haveMeal:(NSString *)food;

/// 声明实例方法,但未实现
/// @param songName 歌曲名称
-(void)singSong:(NSString *)songName;

@end












@interface KKPersonHelper : NSObject

/// 拥有的技能
/// @param skill 技能
-(void)haveSkill:(NSString *)skill;
+(void)haveSkill:(NSString *)skill;


/// 拥有水果
/// @param fruit 水果
-(void)haveFruit:(NSString *)fruit;

/// 拥有水果
/// @param fruit 水果
+(void)haveFruit:(NSString *)fruit;

@end

#pragma mark - 消息标准转发
@interface KKEngineer : KKPerson

/// 工程师拥有的技能
/// @param skill 技能
-(void)haveSkill:(NSString *)skill;
+(void)haveSkill:(NSString *)skill;

@end




#pragma mark -消息快速转发
@interface KKFarmer : KKPerson

/// 拥有水果
/// @param fruit 水果
-(void)haveFruit:(NSString *)fruit;

/// 拥有水果
/// @param fruit 水果
+(void)haveFruit:(NSString *)fruit;

/// 吃水果
/// @param fruit 水果
-(void)eatFruit:(NSString *)fruit;


@end


NS_ASSUME_NONNULL_END
