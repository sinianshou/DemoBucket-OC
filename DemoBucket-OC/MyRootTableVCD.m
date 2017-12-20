//
//  MyRootTableVCD.m
//  DemoBucket-OC
//
//  Created by Easer Liu on 23/11/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//

#import "MyRootTableVCD.h"
#import "MyRootTableViewCell.h"
#import "DynamicAnimatorTest.h"

@implementation MyRootTableVCD

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyRootTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIViewController * toVC = nil;
    if ([cell.restorationIdentifier isEqualToString:@"UIDynamicAnimator"]) {
        toVC = [[DynamicAnimatorTest alloc] initWithDynamicAnimatorType:indexPath.row];
    }
    if (toVC) {
        [self.myRootTableViewController.navigationController pushViewController:toVC animated:YES];
    }
}

@end

