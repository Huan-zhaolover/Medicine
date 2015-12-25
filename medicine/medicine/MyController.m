//
//  MyController.m
//  medicine
//
//  Created by Yutao on 15/11/26.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "MyController.h"

#import "Zixun.h"
#import "Fenlei.h"
#import "Yinpin.h"
#import "Shipin.h"
#import "AppDelegate.h"

#import "ListController.h"

#import "dataHandeler.h"

@interface MyController ()
@property (nonatomic,strong)NSArray *arr;

@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(qingchu:)];
    _arr=@[@"分类",@"资讯",@"音频列表",@"视频列表"];
    
}
//-(void)qingchu:(UIBarButtonItem *)bababa{
//    NSLog(@"登陆");
//
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return _arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellmy" forIndexPath:indexPath];
    
   cell.textLabel.text=_arr[indexPath.row];
    cell.backgroundColor=[UIColor grayColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListController *listvc=[[ListController alloc]init];
    
    switch (indexPath.row) {
        case 0:
            listvc.datasourse=[[dataHandeler sharedataBase]selectFenleimodel].mutableCopy;
            break;
        case 1:
            listvc.datasourse=[[dataHandeler sharedataBase]selectZixumodel].mutableCopy;
            break;
        case 2:
            listvc.datasourse=[[dataHandeler sharedataBase]selectYinpinmodel].mutableCopy;
            break;
        case 3:
            listvc.datasourse=[[dataHandeler sharedataBase]selectShipinmodel].mutableCopy;
            break;
    }

    
    listvc.cellname=self.arr[indexPath.row];
    
    [self.navigationController pushViewController:listvc animated:YES];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
