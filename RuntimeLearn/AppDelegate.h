//
//  AppDelegate.h
//  RuntimeLearn
//
//  Created by hkshen on 2017/9/12.
//  Copyright © 2017年 hkshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

