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
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSArray*>* dataMDic;
@end
@implementation MyRootTableVCDS

-(instancetype)init{
    self = [super init];
    NSDictionary* dic = @{@"RunTime":@[@"Method Swizzle", @"01"], @"Questions":@[@"QSelfNameSetMethod", @"02", @"03"], @"UIDynamicAnimator":@[@"吸附行为", @"推动行为", @"刚性附着", @"软性附着", @"碰撞检测"]};
    if (dic) {
        self.dataMDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MyRootTableViewCell* myRootTableViewCell = [tableView dequeueReusableCellWithIdentifier:[self.dataMDic.allKeys objectAtIndex:indexPath.section]];
    if (!myRootTableViewCell) {
        myRootTableViewCell = [[MyRootTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[self.dataMDic.allKeys objectAtIndex:indexPath.section]];
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
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.dataMDic.allKeys.count; ++i) {
        [arr addObject:@"1"];
    }
    return arr;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.dataMDic.allKeys objectAtIndex:section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataMDic.allKeys.count;
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
    if (self.dataMDic.allKeys.count > section) {
        NSString* sectionKey = [self.dataMDic.allKeys objectAtIndex:section];
        arr = [self.dataMDic objectForKey:sectionKey];
        
    }
    if (arr) {
        return arr;
    }else{
        return NULL;
    }
}


@end
