//
//  FenleiController.m
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "FenleiController.h"
#import "FenleiDataHelper.h"
#import "MovieModel.h"
#import "FoodCell.h"
#import "MiaozhaoCell.h"
#import "NannvCell.h"

#import "SVWebViewController.h"
#import "SVPullToRefresh.h"


@interface FenleiController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UISegmentedControl *headSegement;

@property (weak, nonatomic) IBOutlet UITableView *foodView;

@property (weak, nonatomic) IBOutlet UITableView *miaozhaoView;
@property (weak, nonatomic) IBOutlet UITableView *nannvView;

@property (weak, nonatomic) IBOutlet UIScrollView *fenleiScroll;

@end

@implementation FenleiController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headSegement addTarget:self action:@selector(changecontent:) forControlEvents:UIControlEventValueChanged];
    self.fenleiScroll.delegate=self;
    
    self.foodView.delegate=self;
    self.foodView.dataSource=self;
    
    self.miaozhaoView.delegate=self;
    self.miaozhaoView.dataSource=self;
    
    self.nannvView.delegate=self;
    self.nannvView.dataSource=self;
    
    [[FenleiDataHelper shareFenleiData]setShuaxinBlock:^{
        
        [self.foodView reloadData];
        [self.miaozhaoView reloadData];
        [self.nannvView reloadData];
    }];

    __weak FenleiController *weakSelf = self;
    [self.foodView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertFoodRowAtBottom];
    }];
    
    [self.miaozhaoView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertmiaozhaoZNRowAtBottom];
    }];
    
    [self.nannvView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertNannvRowAtBottom];
    }];
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)insertFoodRowAtBottom{
    NSInteger delaysecond=1.0;
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, delaysecond *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [self.foodView beginUpdates];
        [[FenleiDataHelper shareFenleiData]foodShuaxin];
        [self.foodView endUpdates];
        [self.foodView.infiniteScrollingView stopAnimating];
    });
}

-(void)insertmiaozhaoZNRowAtBottom{
    NSInteger delaysecond=1.0;
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, delaysecond *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [self.miaozhaoView beginUpdates];
        [[FenleiDataHelper shareFenleiData]miaoshuaxin];
        [self.miaozhaoView endUpdates];
        [self.miaozhaoView.infiniteScrollingView stopAnimating];
    });
}

-(void)insertNannvRowAtBottom{
    NSInteger delaysecond=1.0;
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, delaysecond *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [self.nannvView beginUpdates];
        [[FenleiDataHelper shareFenleiData]nannvshuaxin];
        [self.nannvView endUpdates];
        [self.nannvView.infiniteScrollingView stopAnimating];
    });
}

-(void)changecontent:(UISegmentedControl*)segement{
    if (segement.selectedSegmentIndex==0) {
        self.fenleiScroll.contentOffset=CGPointMake(0, 0);
    }else if (segement.selectedSegmentIndex==1){
    
     self.fenleiScroll.contentOffset=CGPointMake(self.miaozhaoView.frame.size.width, 0);
    }
    else{
        self.fenleiScroll.contentOffset=CGPointMake(self.miaozhaoView.frame.size.width *2, 0);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if( scrollView.contentOffset.x/self.miaozhaoView.frame.size.width==0 ){
        self.headSegement.selectedSegmentIndex=0;
    }
    else if (scrollView.contentOffset.x/self.miaozhaoView.frame.size.width==1){
        self.headSegement.selectedSegmentIndex=1;
    }
    else{
        self.headSegement.selectedSegmentIndex=2;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.foodView) {
        
        return [FenleiDataHelper shareFenleiData].FoodListCount;
    }else if (tableView==self.miaozhaoView){
    
        return [FenleiDataHelper shareFenleiData].MiaozhaoListCount;
    }else{
    
        return [FenleiDataHelper shareFenleiData].NannvListCount;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.foodView) {
        FoodCell *fcell=[tableView dequeueReusableCellWithIdentifier:@"foodcell" forIndexPath:indexPath];
        fcell.model=[[FenleiDataHelper shareFenleiData]getFoodCellAtIndexPath:indexPath];
        return fcell;
        
    }else if (tableView==self.nannvView){
        NannvCell *ncell=[tableView dequeueReusableCellWithIdentifier:@"nannvcell" forIndexPath:indexPath];
        ncell.model=[[FenleiDataHelper shareFenleiData]getNannvCellAtIndexPath:indexPath];
        return ncell;
    }else{
        MiaozhaoCell *mcell=[tableView dequeueReusableCellWithIdentifier:@"miaozhaocell" forIndexPath:indexPath];
        mcell.model=[[FenleiDataHelper shareFenleiData]getMiaozhaoCellAtIndexPath:indexPath];
        return mcell;
    }
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView==self.foodView) {
      MovieModel*  model=[[FenleiDataHelper shareFenleiData]getFoodCellAtIndexPath:indexPath];
        SVWebViewController *webcontroller=[[SVWebViewController alloc]initWithURL:[NSURL URLWithString:model.content_url]];
        
        webcontroller.cctableName=self.navigationItem.title;
        webcontroller.cctitle=model.title;
        webcontroller.ccurl=model.content_url;
        
        [self.navigationController pushViewController:webcontroller animated:YES];
        
    }else if (tableView==self.nannvView){
        MovieModel*  model=[[FenleiDataHelper shareFenleiData]getNannvCellAtIndexPath:indexPath];
        SVWebViewController *webcontroller=[[SVWebViewController alloc]initWithURL:[NSURL URLWithString:model.content_url]];
        
        webcontroller.cctableName=self.navigationItem.title;
        webcontroller.cctitle=model.title;
        webcontroller.ccurl=model.content_url;
        
        [self.navigationController pushViewController:webcontroller animated:YES];
    }else{
        MovieModel*  model=[[FenleiDataHelper shareFenleiData]getMiaozhaoCellAtIndexPath:indexPath];
        SVWebViewController *webcontroller=[[SVWebViewController alloc]initWithURL:[NSURL URLWithString:model.content_url]];
        
        webcontroller.cctableName=self.navigationItem.title;
        webcontroller.cctitle=model.title;
        webcontroller.ccurl=model.content_url;
        
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
