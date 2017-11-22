//
//  AppDelegate.h
//  DemoBucket-OC
//
//  Created by Easer Liu on 22/11/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

