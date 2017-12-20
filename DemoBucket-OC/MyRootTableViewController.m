//
//  MyRootTableViewController.m
//  DemoBucket-OC
//
//  Created by Easer Liu on 23/11/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//

#import "MyRootTableViewController.h"
#import "MyRootTableVCD.h"
#import "MyRootTableVCDS.h"
#import "Masonry.h"

@interface MyRootTableViewController ()

@property (nonatomic, strong) MyRootTableVCDS <UITableViewDataSource> *myRootTableVCDS;
@property (nonatomic, strong) MyRootTableVCD <UITableViewDelegate> *myRootTableVCD;

@end
@implementation MyRootTableViewController

-(void)configSelf
{
    NSDictionary* dic = @{@"RunTime":@[@"Method Swizzle", @"01"],
                          @"Questions":@[@"QSelfNameSetMethod", @"02", @"03"],
                          @"UIDynamicAnimator":@[@"吸附行为", @"推动行为", @"刚性附着", @"软性附着", @"碰撞检测"],
                          @"数据结构":@[@"线性表", @"二叉树"],
                          @"各种算法":@[@"时间复杂度计算", @"数组元素循环位移"]};
    
    if (dic) {
        self.dataMDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    MyRootTableVCD* myRootTableVCDIVar = [[MyRootTableVCD alloc] init];
    myRootTableVCDIVar.myRootTableViewController = self;
    self.tableView.delegate = myRootTableVCDIVar;
    self.myRootTableVCD = myRootTableVCDIVar;
    MyRootTableVCDS* myRootTableVCDSIVar = [[MyRootTableVCDS alloc] init];
    myRootTableVCDSIVar.myRootTableViewController = self;
    self.tableView.dataSource = myRootTableVCDSIVar;
    self.myRootTableVCDS = myRootTableVCDSIVar;
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.title = [NSString stringWithFormat:@"DinamicList"];
    self.navigationController.title = self.navigationItem.title;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSelf];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}
*/
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 100;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
