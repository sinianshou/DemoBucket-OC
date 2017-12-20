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
    NSMutableDictionary  *dataMDic = self.myRootTableViewController.dataMDic;
    switch ([dataMDic.allKeys indexOfObject:cell.reuseIdentifier]) {
//        case 0:
//            toVC = [[DynamicAnimatorTest alloc] initWithDynamicAnimatorType:indexPath.row];
//            break;
            
        default:
            break;
    }
    if (toVC) {
        [self.myRootTableViewController.navigationController pushViewController:toVC animated:YES];
    }
//    if ([cell.reuseIdentifier isEqualToString:@"UIDynamicAnimator"]) {
//        DynamicAnimatorTest *DAT = [[DynamicAnimatorTest alloc] initWithDynamicAnimatorType:indexPath.row];
//        [self.myRootTableViewController.navigationController pushViewController:DAT animated:YES];
//    }
}


@end

