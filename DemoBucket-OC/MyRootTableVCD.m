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
    if ([cell.reuseIdentifier isEqualToString:@"UIDynamicAnimator"]) {
        DynamicAnimatorTest *DAT = [[DynamicAnimatorTest alloc] initWithDynamicAnimatorType:indexPath.row];
        [self.myRootTableViewController.navigationController pushViewController:DAT animated:YES];
        
    }
}

@end

