//
//  NewsController.m
//  medicine
//
//  Created by Yutao on 15/11/23.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "NewsController.h"
#import "NewsHandler.h"
#import "newsCell.h"
#import "SVWebViewController.h"
#import "newsModel.h"

#import "newsznModel.h"
#import "newsznCell.h"
#import "newznHandeler.h"

#import "SVPullToRefresh.h"
#import "MyController.h"
@interface NewsController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *shuxindataArry;

@property (strong, nonatomic) IBOutlet UISegmentedControl *newsSegment;

@property (weak, nonatomic) IBOutlet UITableView *zixunTable;

@property (weak, nonatomic) IBOutlet UITableView *zhinanTable;
 
@property (weak, nonatomic) IBOutlet UIScrollView *newsScrollView;


@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.newsSegment addTarget:self action:@selector(changecontent:) forControlEvents:UIControlEventValueChanged];
    
    self.newsScrollView.delegate=self;
    self.zhinanTable.delegate=self;
    self.zhinanTable.dataSource=self;
    self.zixunTable.dataSource=self;
    self.zixunTable.delegate=self;
    self.newsScrollView.contentOffset=CGPointMake(0, 0);
    
    __weak UITableView *table=self.zixunTable;
    [[NewsHandler shareNewData]  setHuidiaoBlock:^{
        [table reloadData];
    }];

    __weak UITableView *table1=self.zhinanTable;
    [[newznHandeler shareZNdata] setShuaxinBlock:^{
        [table1 reloadData];
    }];
    
    __weak NewsController *weakSelf = self;
     [self.zixunTable addInfiniteScrollingWithActionHandler:^{
         [weakSelf insertRowAtBottom];
     }];
    
    [self.zhinanTable addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertZNRowAtBottom];
    }];
}

- (void)insertRowAtBottom{

    NSInteger delaysecond=1.0;
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, delaysecond *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [self.zixunTable beginUpdates];
        [[NewsHandler shareNewData]infinteData];
        [self.zixunTable endUpdates];
        [self.zixunTable.infiniteScrollingView stopAnimating];
    });
    
}


-(void)insertZNRowAtBottom{
    
    NSInteger delaysecond=1.0;
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, delaysecond *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [self.zhinanTable beginUpdates];
        [[newznHandeler shareZNdata]xialashuxin];
        [self.zhinanTable endUpdates];
        [self.zhinanTable.infiniteScrollingView stopAnimating];
        
    });
}

-(void)changecontent:(UISegmentedControl*)segement{
    if (segement.selectedSegmentIndex==0) {
       self.newsScrollView.contentOffset=CGPointMake(0, 0);
    }else{
        self.newsScrollView.contentOffset=CGPointMake(self.zixunTable.frame.size.width, 0);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if( scrollView.contentOffset.x/self.zixunTable.frame.size.width==0  )
        self.newsSegment.selectedSegmentIndex=0;
    else{
        self.newsSegment.selectedSegmentIndex=1;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.zixunTable) {
        NSLog(@"1111111%ld",[NewsHandler shareNewData].count);
        
        return [NewsHandler shareNewData].count;
    }else{
        NSLog(@"222222%ld",[newznHandeler shareZNdata].count);
        return [newznHandeler shareZNdata].count;
    }
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.zixunTable) {
        newsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell-1" forIndexPath:indexPath];
        if (!cell) {
            cell=[[newsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell-1"];
        }
        cell.newsmodel=[[NewsHandler shareNewData]getModelAtIndexPath:indexPath];
        return cell;

        
    }else{
        newsznCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"cell-2" forIndexPath:indexPath];
        if (!cell1) {
            cell1=[[newsznCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell-2"];
        }
        cell1.znmodel=[[newznHandeler shareZNdata] getZNmodelAtIndexPath:indexPath];
        return cell1;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.zixunTable) {
        
        newsModel *model=[[NewsHandler shareNewData]getModelAtIndexPath:indexPath]; 
        
        SVWebViewController *webcontroller=[[SVWebViewController alloc]initWithURL:[NSURL URLWithString:model.url]];
        
        webcontroller.cctableName=self.navigationItem.title;
        webcontroller.cctitle=model.title;
        webcontroller.ccurl=model.url;
      
        [self.navigationController pushViewController:webcontroller animated:YES];
        
    }
    else{
        newsznModel *model=[[newznHandeler shareZNdata] getZNmodelAtIndexPath:indexPath];
        SVWebViewController *webcontroller=[[SVWebViewController alloc]initWithURL:[NSURL URLWithString:model.url]];
        
        
        webcontroller.cctableName=self.navigationItem.title;
        webcontroller.cctitle=model.title;
        webcontroller.ccurl=model.url;
        
        [self.navigationController pushViewController:webcontroller animated:YES];
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
