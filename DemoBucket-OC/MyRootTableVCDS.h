//
//  MyRootTableVCDS.h
//  DemoBucket-OC
//
//  Created by Easer Liu on 23/11/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRootTableViewController.h"

@interface MyRootTableVCDS : NSObject <UITableViewDataSource>

@property (nonatomic, weak) MyRootTableViewController *myRootTableViewController;

@end
