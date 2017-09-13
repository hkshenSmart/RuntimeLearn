//
//  Person.m
//  RuntimeLearn
//
//  Created by hkshen on 2017/9/12.
//  Copyright © 2017年 hkshen. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Dog.h"

@interface Person ()

- (void)doSleep;

@end

@implementation Person {
    
    NSString *name; // 实例变量
    Dog *dog;
}

//@synthesize age;
// 相当于@synthesize age = age; 不写@synthesize age; 实例变量_age;

- (instancetype)init {
    
    if (self = [super init]) {
        name = @"hkshen";
        self.age = 27;
        
        dog = [[Dog alloc] init];
    }
    return self;
}

- (void)doAddingTalk:(NSString *)str {
    
    NSLog(@"doAddingTalk:%@", str);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    // 给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"doTalk:"]) {
        class_addMethod(self, sel, class_getMethodImplementation(self, @selector(doAddingTalk:)), "v@:*");
    }
    return YES;
}

- (void)doWork {
    
    NSLog(@"Work alive");
}

- (void)doEat {
    
    NSLog(@"Eat alive");
}

- (void)doSleep {
    
    NSLog(@"Sleep alive");
}

// Person里没有doRunFastDog
- (void)doRunFastPerson {
    
    [self performSelector:@selector(doRunFastDog)];
}

/*
 * 转发给其他对象1
 */
/*
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    NSString *aSelectorStr = NSStringFromSelector(aSelector);
    // 将消息转发给dog处理
    if ([aSelectorStr isEqualToString:@"doRunFastDog"]) {
        return dog;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}
 */

/*
 * 转发给其他对象2
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    
    if (!methodSignature) {
        if ([Dog instancesRespondToSelector:aSelector]) {
            methodSignature = [Dog instanceMethodSignatureForSelector:aSelector];
        }
    }
    return methodSignature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    if ([Dog instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:dog];
    }
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"name:%@---age:%d", name, self.age];
}

@end
