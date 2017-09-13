//
//  Person+Sex.m
//  RuntimeLearn
//
//  Created by hkshen on 2017/9/13.
//  Copyright © 2017年 hkshen. All rights reserved.
//

#import "Person+Sex.h"
#import <objc/runtime.h>

const char *keyStr = "Sex"; // 做为key，字符常量，必须是C语言字符串

@implementation Person (Sex)

- (void)setSex:(NSString *)sex {
    
    /*
     第一个参数是需要添加属性的对象。
     第二个参数是属性的key。
     第三个参数是属性的值。
     第四个参数是使用的策略，是一个枚举值，可根据开发需要选择不同的枚举。
     */
    objc_setAssociatedObject(self, keyStr, sex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)sex {
    
    NSString *sexStr = objc_getAssociatedObject(self, keyStr);
    return sexStr;
}

@end
