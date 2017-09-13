//
//  ViewController.m
//  RuntimeLearn
//
//  Created by hkshen on 2017/9/12.
//  Copyright © 2017年 hkshen. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "Person+Sex.h"

@interface ViewController () {
    
    Person *person;
}

- (IBAction)doGetAllVariable:(id)sender; // 获取变量
- (IBAction)doGetAllMethod:(id)sender; // 获取方法
- (IBAction)doChangeVariableValue:(id)sender; // 改变私有变量的值
- (IBAction)doAddMethod:(id)sender; // 添加新方法
- (IBAction)doAddVariable:(id)sender; // 添加新属性
- (IBAction)doReplaceMethod:(id)sender; // 交换两个方法

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    person = [[Person alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button functions

- (IBAction)doGetAllVariable:(id)sender {
    
    unsigned int count = 0;
    
    // 类中所有变量的列表
    Ivar *allVariables = class_copyIvarList([person class], &count);
    for (int i = 0; i < count; i ++) {
        // 遍历变量列表
        Ivar ivar = allVariables[i];
        
        const char *ivarName = ivar_getName(ivar); // 变量名称，实例变量
        const char *ivarType = ivar_getTypeEncoding(ivar); // 变量类型
        NSLog(@"变量名称:%s---变量类型:%s", ivarName, ivarType);
    }
}

- (IBAction)doGetAllMethod:(id)sender {
    
    unsigned int count = 0;
    
    // 获取方法列表，所有在.m文件显式实现的方法都会被找到，包括setter和getter方法
    Method *allMethods = class_copyMethodList([person class], &count);
    for (int i = 0; i < count; i ++) {
        // 遍历方法列表
        Method method = allMethods[i];
        
        // SEL类型，即获取方法选择器@selector()
        SEL sel = method_getName(method);
        // @selector()中方法名称
        const char *methodName = sel_getName(sel);
        NSLog(@"方法名称:%s", methodName);
    }
}

- (IBAction)doChangeVariableValue:(id)sender {
    
    NSLog(@"改变前:%@", person);
    
    unsigned int count = 0;
    
    // 类中所有变量的列表
    Ivar *allVariables = class_copyIvarList([person class], &count);
    Ivar nameIvar = allVariables[0];
    
    // name的hkshen改为wanglanman
    object_setIvar(person, nameIvar, @"wanglanman");
    
    NSLog(@"改变后:%@", person);
    
}

- (IBAction)doAddMethod:(id)sender {
    
    /*
     第一个参数表示Class cls 类型。
     第二个参数表示待调用的方法名称。
     第三个参数(IMP)addingMethod，IMP一个函数指针，这里表示指定具体实现方法addingMethod。
     第四个参数表方法的参数，0代表没有参数。
     */
    // addingMethod在ViewController类中，需要实现class_getMethodImplementation才行
    class_addMethod([person class], @selector(NewMethod), class_getMethodImplementation([ViewController class], @selector(addingMethod)), 0);
    
    [person performSelector:@selector(NewMethod)];
}

- (void)addingMethod {
    
    NSLog(@"已经增加了方法:NewMethod");
}

- (IBAction)doAddVariable:(id)sender {
    
    person.sex = @"男";
    NSLog(@"new variable:%@", person.sex);
}

- (IBAction)doReplaceMethod:(id)sender {
    
    Method method1 = class_getInstanceMethod([person class], @selector(doWork));
    Method method2 = class_getInstanceMethod([person class], @selector(doEat));
    method_exchangeImplementations(method1, method2);
    
    [person doWork];  //查看交换后的结果
}

@end
