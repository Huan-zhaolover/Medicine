//
//  MovieListController.m
//  medicine
//
//  Created by Yutao on 15/11/24.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "MovieListController.h"
#import "MediaHandeler.h"
#import "movieCell.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SVWebViewController.h"

#import "SVPullToRefresh.h"

@interface MovieListController ()

@end

@implementation MovieListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[MediaHandeler shareMovieData]setShuaxinBlock:^{
        [self.tableView reloadData];
    }];
    
    __weak MovieListController *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
  
}
-(void)insertRowAtBottom{
    NSInteger delaysecond=1.0;
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, delaysecond *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [self.tableView beginUpdates];
        
        [[MediaHandeler shareMovieData]shuxinMovie];
        
        [self.tableView endUpdates];
        [self.tableView.infiniteScrollingView stopAnimating];
    });

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
   // return 10;
   return [MediaHandeler shareMovieData].movieListCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    movieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moviecell" forIndexPath:indexPath];
    
    
    cell.model=[[MediaHandeler shareMovieData] getMovieModelAtIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieModel* model=[[MediaHandeler shareMovieData] getMovieModelAtIndexPath:indexPath];

    NSString *strurl=[model.content_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MPMoviePlayerViewController *mpview=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:strurl]];
    [self.navigationController presentMoviePlayerViewControllerAnimated:mpview];
    
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
