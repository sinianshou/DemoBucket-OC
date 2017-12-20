//
//  MyRootTableVCDS.m
//  DemoBucket-OC
//
//  Created by Easer Liu on 23/11/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//

#import "MyRootTableVCDS.h"
#import "MyRootTableViewCell.h"
@interface MyRootTableVCDS ()
@end
@implementation MyRootTableVCDS

-(instancetype)init{
    self = [super init];
    return self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString * identifier = [self.myRootTableViewController.dataMDic.allKeys objectAtIndex:indexPath.section];
    MyRootTableViewCell* myRootTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!myRootTableViewCell) {
        myRootTableViewCell = [[MyRootTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSArray* arr = [self getRowsArrInSection:indexPath.section];
    if (arr) {
        myRootTableViewCell.textLabel.text = [arr objectAtIndex:indexPath.row];
        myRootTableViewCell.accessoryType = UITableViewCellAccessoryDetailButton;
        myRootTableViewCell.detailTextLabel.text = [arr objectAtIndex:indexPath.row];
    }
    myRootTableViewCell.backgroundColor = [UIColor brownColor];
    return myRootTableViewCell;
}
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.myRootTableViewController.dataMDic.allKeys;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.myRootTableViewController.dataMDic.allKeys objectAtIndex:section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.myRootTableViewController.dataMDic.allKeys.count;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* arr = [self getRowsArrInSection:section];
    if (arr) {
        return arr.count;
    }else{
        return 0;
    }
}
-(nonnull NSArray*)getRowsArrInSection:(NSInteger)section{
    NSArray* arr;
    if (self.myRootTableViewController.dataMDic.allKeys.count > section) {
        NSString* sectionKey = [self.myRootTableViewController.dataMDic.allKeys objectAtIndex:section];
        arr = [self.myRootTableViewController.dataMDic objectForKey:sectionKey];
        
    }
    return arr;
//    if (arr) {
//        return arr;
//    }else{
//        return NULL;
//    }
}


@end
