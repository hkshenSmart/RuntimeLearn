//
//  Person.h
//  RuntimeLearn
//
//  Created by hkshen on 2017/9/12.
//  Copyright © 2017年 hkshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, assign) int age; // 属性

- (void)doWork;
- (void)doEat;
- (void)doRunFastPerson;

@end
