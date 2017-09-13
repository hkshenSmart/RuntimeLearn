//
//  Person.m
//  RuntimeLearn
//
//  Created by hkshen on 2017/9/12.
//  Copyright © 2017年 hkshen. All rights reserved.
//

#import "Person.h"

@interface Person ()

- (void)doSleep;

@end

@implementation Person {
    
    NSString *name; // 实例变量
}

//@synthesize age;
// 相当于@synthesize age = age; 不写@synthesize age; 实例变量_age;

- (instancetype)init {
    
    if (self = [super init]) {
        name = @"hkshen";
        self.age = 27;
    }
    return self;
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

- (NSString *)description {
    
    return [NSString stringWithFormat:@"name:%@---age:%d", name, self.age];
}

@end
